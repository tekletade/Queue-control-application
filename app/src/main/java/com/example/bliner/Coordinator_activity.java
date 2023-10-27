package com.example.bliner;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

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

public class Coordinator_activity extends AppCompatActivity {

    private ArrayList<coordinator> coordinatorlist;
    coordinator_adapter adapter;

    String responseStr;
    public String url= "https://liner12.000webhostapp.com/liner/manage_service.php";
    public String qurl= "https://liner12.000webhostapp.com/liner/manage_queue.php";
    private String uid;
    public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private ListView colist;
String gcid;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_coordinator);
        colist = findViewById(R.id.coord_listview);
        Bundle extras = getIntent().getExtras();
        uid=extras.getString("uid");
        gcid=extras.getString("gcid");
        Log.v("userrrrrrvccccc",uid);
        String postBody="{\n" +
                "    \"coordinator\": \""+uid+"\",\n" +
                "    \"loginpin\": \"test\"\n" +
                "}";
        try {
                coordinator_async oassync=new coordinator_async(this, colist, uid,"");
                oassync.execute("coordlist",uid);
                //postRequest(url,postBody);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}