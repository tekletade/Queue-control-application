package com.example.bliner;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.HttpUrl;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;



import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;


public class LoginActivity extends AppCompatActivity implements View.OnClickListener {

OkHttpClient client = new OkHttpClient();

    TextView txtString;

    public String url= "https://liner12.000webhostapp.com/liner/manage_user.php";
    private ProgressBar loadingPB;
    private EditText phone,pin;
    private LoginOkHttpHandler okHttpHandler;
    public String postBody="";

    public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private String responseStr;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        //Background image
//        View lll = (View)findViewById(R.id.relative_layout);
//        lll.setBackgroundResource(R.drawable.f2);

        Button logbut=(Button) findViewById(R.id.logbutton);
        phone=(EditText) findViewById(R.id.editTextPhone);
        pin=(EditText) findViewById(R.id.editTextPhonePassword);
        logbut.setOnClickListener(this);

        txtString= (TextView)findViewById(R.id.textdonot);
        loadingPB = findViewById(R.id.idLoadingPB);
        okHttpHandler= new LoginOkHttpHandler();
    }

    // Declare the launcher at the top of your Activity/Fragment:
    private final ActivityResultLauncher<String> requestPermissionLauncher =
            registerForActivityResult(new ActivityResultContracts.RequestPermission(), isGranted -> {
                if (isGranted) {
                    // FCM SDK (and your app) can post notifications.
                } else {
                    // TODO: Inform user that that your app will not show notifications.
                }
            });

    private void askNotificationPermission() {
        // This is only necessary for API level >= 33 (TIRAMISU)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS) ==
                    PackageManager.PERMISSION_GRANTED) {
                // FCM SDK (and your app) can post notifications.
            } else if (shouldShowRequestPermissionRationale(Manifest.permission.POST_NOTIFICATIONS)) {
                // TODO: display an educational UI explaining to the user the features that will be enabled
                //       by them granting the POST_NOTIFICATION permission. This UI should provide the user
                //       "OK" and "No thanks" buttons. If the user selects "OK," directly request the permission.
                //       If the user selects "No thanks," allow the user to continue without notifications.
            } else {
                // Directly ask for the permission
                requestPermissionLauncher.launch(Manifest.permission.POST_NOTIFICATIONS);
            }
        }
    }
    @Override
    public void onClick(View v) {

        postBody="{\n" +
                "    \"loginphone\": \""+phone.getText().toString()+"\",\n" +
                "    \"loginpin\": \""+pin.getText().toString()+"\"\n" +
                "}";
        try {
            postRequest(url, postBody);
        }catch (Exception ex){}

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
                    JSONObject nodeStats = nodeRoot.getJSONObject("stats");
                    Log.v("ererrr",nodeStats.getString("uid"));
                    /*Intent in = new Intent(getApplicationContext(), Coordinator_activity.class);
                    in.putExtra("uid",nodeStats.getString("uid"));
                    startActivity(in);*/
                    Intent in=new Intent(getApplicationContext(),Company_dashboard.class);
                    in.putExtra("uid",nodeStats.getString("uid"));
                    in.putExtra("phone",nodeStats.getString("phone"));
                    in.putExtra("lname",nodeStats.getString("lname"));
                    in.putExtra("fname",nodeStats.getString("fname"));
                    startActivity(in);

                }catch (Exception ex){
                    Log.v("ddddd",ex.getMessage());
                }
            }
        });
        return responseStr;
    }
}