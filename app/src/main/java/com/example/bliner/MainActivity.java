package com.example.bliner;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.view.Menu;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.Toast;

import com.google.android.material.snackbar.Snackbar;
import com.google.android.material.navigation.NavigationView;

import androidx.annotation.NonNull;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.appcompat.app.AppCompatActivity;

import com.example.bliner.databinding.ActivityMainBinding;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class MainActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener{

    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

    private AppBarConfiguration mAppBarConfiguration;
    private ActivityMainBinding binding;
Intent intent;

    private String uid;
    private String fname;
    private String lname;
    private String phone;
    private String responseStr;
    public String url= "https://liner12.000webhostapp.com/liner/manage_company.php";
    private ArrayList<company> comps;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
intent=new Intent();
        Bundle extras = getIntent().getExtras();
        uid = extras.getString("uid");
        fname = extras.getString("fname");
        lname = extras.getString("lname");
        phone = extras.getString("phone");
        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        setSupportActionBar(binding.appBarMain.toolbar);
        binding.appBarMain.fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });
        try {String postBody="{}";
            Log.v("compppppp33",uid+" started");
            postRequest(url, postBody);
            Toast.makeText(this, " "+comps.size()+" "+comps.get(0).getName(), Toast.LENGTH_SHORT).show();

        }catch (Exception ex){
            Log.v("compppppp error ",ex.getMessage());}
        try {
            Log.v("4444444",comps.size()+" is length "+comps.get(0).getCid());


        DrawerLayout drawer = binding.drawerLayout;
        NavigationView navigationView = binding.navView;
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        mAppBarConfiguration = new AppBarConfiguration.Builder(
                R.id.nav_home, R.id.nav_issued, R.id.nav_agent)
                .setOpenableLayout(drawer)
                .build();
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment_content_main);
        NavigationUI.setupActionBarWithNavController(this, navController, mAppBarConfiguration);
        NavigationUI.setupWithNavController(navigationView, navController);
            navigationView.setNavigationItemSelectedListener(this);
        }catch (Exception ex){
            Log.v("******* errr: ",ex.getLocalizedMessage());
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);

        return true;
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.nav_issued:
                Intent ins = new Intent(this, Issuer_Activity.class);
                ins.putExtra("uid",uid);
                startActivity(ins);
                return true;
            case R.id.nav_agent:
                Intent in = new Intent(this, Coordinator_activity.class);
                in.putExtra("uid",uid);
                startActivity(in);
                return true;
            case R.id.nav_home:
                Toast.makeText(this,"ssss"+item.getItemId(),Toast.LENGTH_SHORT).show();
// do whatever
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        // Handle the menu item with the switch

        Toast.makeText(this,"ssss"+item.getItemId(),Toast.LENGTH_SHORT).show();
        if (item.getItemId() == R.id.nav_agent) {
            Intent in = new Intent(this, Coordinator_activity.class);
            in.putExtra("uid",uid);
            startActivity(in);
            return false; // Prevent the menu item to get selected (No overlay indicator will appear)
        }
        return true;
    }
    @Override
    public boolean onSupportNavigateUp() {
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment_content_main);
        return NavigationUI.navigateUp(navController, mAppBarConfiguration)
                || super.onSupportNavigateUp();
    }

    String postRequest(String postUrl,String postBody) throws IOException {
        OkHttpClient client = new OkHttpClient();
        RequestBody body = RequestBody.create(JSON, postBody);
        Request request = new Request.Builder()
                .url(postUrl)
                .post(body)
                .build();

        responseStr="";
        client.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                call.cancel();
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                responseStr=response.peekBody(2048).string();
                try {
                    JSONObject nodeRoot  = new JSONObject(responseStr);
                    Log.v("00000w",nodeRoot.toString());
                    JSONArray jsonArray = new JSONArray(nodeRoot.getString("compstatus"));
                    Log.v("00000",jsonArray.toString());
                    comps  = new ArrayList<company>();company c;
                    for(int i = 0 ; i < jsonArray.length(); i ++){
                        JSONObject jsonObject = jsonArray.getJSONObject(i);
                        c=new company(jsonObject.getString("cid"),jsonObject.getString("name"),
                                jsonObject.getString("branchname"),jsonObject.getString("location"),
                                jsonObject.getString("isbranch"));
                        comps.add(c);
                        Log.v("00000hh",jsonObject.toString());

                    }
                    GridView gridview = (GridView) findViewById(R.id.gridview);
                    gridview.setAdapter(new dashboardAdapter(getApplicationContext(),comps));
                    gridview.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                        public void onItemClick(AdapterView<?> parent,
                                                View v, int position, long id){
                            // Send intent to SingleViewActivity
                            //  Intent i = new Intent(getApplicationContext(), CompActivity.class);
                            Intent i = new Intent(getApplicationContext(), ServiceActivity.class);
                            i.putExtra("cid",comps.get(position).getCid());
                            i.putExtra("uid",uid);
                            startActivity(i);
                            // Pass image index
                            // i.putExtra("id", position);
                        }
                    });
                    //responseStr=respon
                }catch (Exception ex){
                    Log.v("dddddvvv",ex.getMessage());
                }
            }
        });
        return responseStr;
    }
}