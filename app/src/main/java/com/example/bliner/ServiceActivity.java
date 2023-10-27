package com.example.bliner;

import androidx.appcompat.app.AppCompatActivity;

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

public class ServiceActivity extends AppCompatActivity {
    ListView listView;
    private ArrayList<service> svcs;
    serviceAdapter adapter;

    String responseStr;
    public String url= "https://liner12.000webhostapp.com/liner/manage_service.php";
    public String qurl= "https://liner12.000webhostapp.com/liner/manage_queue.php";

    public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private String cid,uid;
    LinearLayout ln;
    Button issuebtn,issueforother;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_service);
        listView = findViewById(R.id.listView);
        ln=(LinearLayout)findViewById(R.id.laybtns);
        ln.setVisibility(View.INVISIBLE);
        issuebtn=(Button)findViewById(R.id.issuebtn);
        issueforother=(Button)findViewById(R.id.issueforother);
        Bundle extras = getIntent().getExtras();
        cid=extras.getString("cid");
        uid=extras.getString("uid");

        String postBody="{\n" +
                "    \"gcid\": \""+cid+"\",\n" +
                "    \"loginpin\": \"test\"\n" +
                "}";
        try {
            service_async oassync=new service_async(this,listView,uid,cid,ln,issuebtn,issueforother);
            oassync.execute("servlist",cid);
            //postRequest(url,postBody);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // handle arrow click here
        if (item.getItemId() == android.R.id.home) {
            finish(); // close this activity and return to preview activity (if there is any)
        }

        return super.onOptionsItemSelected(item);
    }
    String postRequest(String postUrl,String postBody) throws IOException {
        OkHttpClient client = new OkHttpClient();
        RequestBody body = RequestBody.create(JSON, postBody);
        Request request = new Request.Builder()
                .url(postUrl)
                .post(body)
                .build();


        client.newCall(request).enqueue(new Callback() {

            @Override
            public void onFailure(Call call, IOException e) {
                call.cancel();
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                responseStr=response.peekBody(2048).string();
                try {
                    Log.v("00000wsssssssss",responseStr.toString());
                    JSONObject nodeRoot  = new JSONObject(responseStr);
                    JSONArray jsonArray = new JSONArray(nodeRoot.getString("compstatus"));
                    Log.v("00000sss",jsonArray.toString());
                    svcs  = new ArrayList<service>();
                    service s;
                    for(int i = 0 ; i < jsonArray.length(); i ++){
                        JSONObject jsonObject = jsonArray.getJSONObject(i);
                        s=new service(jsonObject.getString("name"),jsonObject.getString("total"),
                                jsonObject.getString("current"),jsonObject.getString("status")
                                ,jsonObject.getString("sid"),jsonObject.getString("coordinator"));
                        svcs.add(s);
                        Log.v("00000hssssh",jsonObject.toString());

                    }

                    adapter = new serviceAdapter(getApplicationContext(), svcs);
                    listView.setAdapter(adapter);
                    listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                        public void onItemClick(AdapterView<?> parent,
                                                View v, int position, long id) {
                            Toast.makeText(getApplicationContext(), position + "   " + id, Toast.LENGTH_SHORT).show();
                            String postBody3= "{\n" +
                                    "    \"sid\": \""+svcs.get(position).getSid()+"\",\n" +
                                    "    \"uid\": \""+uid+"\",\n" +
                                    "    \"comment\": \"valid\",\n" +
                                    "    \"status\": \"\",\n" +
                                    "    \"coordinator\": \""+svcs.get(position).getCoordinator()+"\",\n" +
                                    "    \"callqueue\": \"test\"\n" +
                                    "}";
                            String postBody2= "{\n" +
                                    "    \"sid\": \""+svcs.get(position).getSid()+"\",\n" +
                                    "    \"token\": \""+uid+"\",\n" +
                                    "    \"channel\": \"android\"\n" +
                                    "}";  ;
                            try {
                                postRequest2( qurl, postBody2);
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }
                    });
                    //responseStr=respon
                }catch (Exception ex){
                    Log.v("dddddvvv",ex.getMessage());
                    ex.printStackTrace();
                }
            }
        });
        return responseStr;
    }
    String postRequest2(String postUrl,String postBody) throws IOException {
        OkHttpClient client = new OkHttpClient();
        RequestBody body = RequestBody.create(JSON, postBody);
        Request request = new Request.Builder()
                .url(postUrl)
                .post(body)
                .build();
//        FirebaseOptions options = new FirebaseOptions.Builder()
//                .setApplicationId("1:771936737647:android:1b950fabaa2318f0c6b09a\n") // Required for Analytics.
//                .setApiKey(apiKey) // Required for Auth.
//                .build();
        FirebaseApp.initializeApp(this);
       /* FirebaseMessaging.getInstance().getToken()
                .addOnCompleteListener(new OnCompleteListener<String>() {
                    @Override
                    public void onComplete(@NonNull Task<String> task) {
                        if (!task.isSuccessful()) {
                            Log.w("ppppppppppp", "Fetching FCM registration token failed", task.getException());
                            return;
                        }
                        // Get new FCM registration token
                        String token = task.getResult();
                        Log.d("pppppppppp", token);
                        Toast.makeText(ServiceActivity.this, token, Toast.LENGTH_SHORT).show();
                    }
                });*/
        client.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                call.cancel();
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                responseStr=response.peekBody(2048).string();
                try {
                    Log.v("00000wsssssssss22",responseStr.toString());
                    JSONObject nodeRoot  = new JSONObject(responseStr);
                   // Toast.makeText(getApplicationContext(),nodeRoot.getString("servstatus").toString(),Toast.LENGTH_LONG).show();

                }catch (Exception ex){
                    Log.v("dddddvvv",ex.getMessage());
                    ex.printStackTrace();
                }
            }
        });
        return responseStr;
    }


    }
