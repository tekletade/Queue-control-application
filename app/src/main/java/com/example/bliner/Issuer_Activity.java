package com.example.bliner;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Toast;

import com.google.firebase.FirebaseApp;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class Issuer_Activity extends AppCompatActivity {

    private ArrayList<service> svcs;
    serviceAdapter adapter;

    String responseStr;
    public String url= "https://liner12.000webhostapp.com/liner/manage_service.php";
    public String qurl= "https://liner12.000webhostapp.com/liner/manage_queue.php";

    public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private String cid,uid;
    LinearLayout ln;
    Button shiftbtn,leavebtn;
    private ListView listView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_issuer);
        listView = findViewById(R.id.issuedlist);
        ln=(LinearLayout)findViewById(R.id.laybtns);
        ln.setVisibility(View.INVISIBLE);
        leavebtn=(Button)findViewById(R.id.leavebtn);
        shiftbtn=(Button)findViewById(R.id.shiftbtn);
        Bundle extras = getIntent().getExtras();
        cid=extras.getString("cid");
        uid=extras.getString("uid");
        try {
            issuer_async oassync=new issuer_async(this,listView,uid,cid,ln,shiftbtn,leavebtn,null);
            oassync.execute("issuedlist",uid);
            //postRequest(url,postBody);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
