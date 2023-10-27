package com.example.bliner;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ExpandableListView;
import android.widget.ListView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.recyclerview.widget.RecyclerView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

public class coordinator_async extends AsyncTask<String,Void,String> {
    Context context;
    String uid,sid;
    ListView coordlistview;
    private ArrayList<coordinator> coords;
    private ArrayList<issuer> issuers;
    private coordinator_adapter adapter;
    private issuer_adapter isadapter;
    private ListView issuerslistview;

    public coordinator_async(Context context, ListView listView, String uid,String sid) {
        this.context = context;
        this.uid = uid;
        this.sid = sid;
        this.coordlistview = listView;
    }

    private void getservList(String result) {
        String res=result;
        Log.v("322222",res);
       // Toast.makeText(context,res,Toast.LENGTH_SHORT).show();
        JSONObject jObj = null;
        try {
            jObj = new JSONObject(res);
            JSONArray jsonArry = jObj.getJSONArray("agentstatus");

            if(jsonArry.length()==0 ){
                AlertDialog.Builder db = new AlertDialog.Builder(context);
                db.setTitle("Notification");
                db.setMessage("You are not coordinator to any service");
                db.setCancelable(false);
                db.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        Intent in=new Intent(context,Company_dashboard.class);
                        in.putExtra("uid",uid);
                        context.startActivity(in);

                    }
                });
                AlertDialog dialog = db.show();
            }
            Log.v("vvvvvvvv",jsonArry.length()+"");
            String action="live";
            coords  = new ArrayList<coordinator>();
            coordinator coord;
            for(int i = 0 ; i < jsonArry.length(); i ++){
                JSONObject jsonObject = jsonArry.getJSONObject(i);
                coord=new coordinator(jsonObject.getString("name")
                        ,jsonObject.getString("sid"),jsonObject.getString("coordinator"),
                        jsonObject.getString("state"),jsonObject.getString("nextrange"),jsonObject.getString("total"));
                coords.add(coord);
                Log.v("00000hssssh",jsonObject.toString());

            }

            adapter = new coordinator_adapter(context, coords,uid,sid);
            coordlistview.setAdapter(adapter);
            coordlistview.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                public void onItemClick(AdapterView<?> parent,
                                        View v, int position, long id) {
                    Log.v("5555555",coords.get(position).getSid());
              //      Toast.makeText(context, position + "  222 " +coords.get(position).getSid(), Toast.LENGTH_SHORT).show();

                }
            });
        } catch (JSONException e) {
          //  Toast.makeText(context,e.getLocalizedMessage(),Toast.LENGTH_SHORT).show();
        }

    }

    @Override
    protected String doInBackground(String... strings) {
        String message = "done";
        try {
            String action = (String) strings[0];
            Log.v("eeettrrrreeee", action);
            if (action.equals("coordlist")) {
                String uid = (String) strings[1];
                String link = "https://liner12.000webhostapp.com/liner/manage_service.php?coordinator=" + uid;
                // String link = "http://192.168.0.2:8050/shells/register.php?fname=3&lname=4&phone=545&pin=6&phoneinfo=phoneinfo";
                Log.v("eeeeeee", link);
                URL url = new URL(link);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                StringBuilder sb = new StringBuilder();
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String json;
                while ((json = bufferedReader.readLine()) != null) {
                    sb.append(json + "\n");
                }
                message = sb.toString().trim();
                // message;
            } else if (action.equals("sessionstatus")) {
                try {
                    String sid = (String) strings[2];
                    String statusid = (String) strings[3];
                    String link = "https://liner12.000webhostapp.com/liner/manage_service.php?" + statusid + "=1&sid=" + sid;
                    // String link = "http://192.168.0.2:8050/shells/register.php?fname=3&lname=4&phone=545&pin=6&phoneinfo=phoneinfo";
                    Log.v("eeeeeee", link);
                    URL url = new URL(link);
                    HttpURLConnection con = (HttpURLConnection) url.openConnection();
                    StringBuilder sb = new StringBuilder();
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()));
                    String json;
                    while ((json = bufferedReader.readLine()) != null) {
                        sb.append(json + "\n");
                    }
                    message = sb.toString().trim();

                } catch (Exception ex) {
                    Log.v("async ex ", ex.getMessage());
                    ex.printStackTrace();
                }
            }
            else if (action.equals("service_q_detail")) {
                try {
                    String sid = (String) strings[1];
                    String link = "https://liner12.000webhostapp.com/liner/manage_service.php?getlistofissuers=222&sid=" + sid;
                    // String link = "http://192.168.0.2:8050/shells/register.php?fname=3&lname=4&phone=545&pin=6&phoneinfo=phoneinfo";
                    Log.v("eeeeeee", link);
                    URL url = new URL(link);
                    HttpURLConnection con = (HttpURLConnection) url.openConnection();
                    StringBuilder sb = new StringBuilder();
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()));
                    String json;
                    while ((json = bufferedReader.readLine()) != null) {
                        sb.append(json + "\n");
                    }
                    message = sb.toString().trim();

                } catch (Exception ex) {
                    Log.v("async ex ", ex.getMessage());
                    ex.printStackTrace();
                }
            }
            else if (action.equals("callfornext")) {
                try {
                    String sid = (String) strings[1];
                    String range = (String) strings[2];
                    String link = "https://liner12.000webhostapp.com/liner/manage_queue.php?range_fornext=" + range
                            + "&sid=" + sid;
                    // String link = "http://192.168.0.2:8050/shells/register.php?fname=3&lname=4&phone=545&pin=6&phoneinfo=phoneinfo";
                    Log.v("eeeeeee", link);

                    URL url = new URL(link);
                    HttpURLConnection con = (HttpURLConnection) url.openConnection();
                    StringBuilder sb = new StringBuilder();
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()));
                    String json;
                    while ((json = bufferedReader.readLine()) != null) {
                        sb.append(json + "\n");
                    }
                    message = sb.toString().trim();
                  /*  Intent in=new Intent(context.getApplicationContext()
                            , coordinator_dashboard.class);
                    in.putExtra("sid",arrayList.get(position).getSid());
                    in.putExtra("coordinator",arrayList.get(position).getCoordinator());
                    context.getApplicationContext().startActivity(in);*/
                } catch (Exception ex) {
                    Log.v("async ex ", ex.getMessage());
                    ex.printStackTrace();
                }
            }
            else if (action.equals("callforqueue")) {
                try {
                    String cuid = (String) strings[1];
                    String sid = (String) strings[2];
                    String coordinator = (String) strings[3];
                    String link = "https://liner12.000webhostapp.com/liner/manage_queue.php?callqueue=&uid=" +
                            cuid + "&sid=" + sid+ "&coordinator=" + coordinator;
                    // String link = "http://192.168.0.2:8050/shells/register.php?fname=3&lname=4&phone=545&pin=6&phoneinfo=phoneinfo";
                    Log.v("eeeeeee", link);
                    URL url = new URL(link);
                    HttpURLConnection con = (HttpURLConnection) url.openConnection();
                    StringBuilder sb = new StringBuilder();
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()));
                    String json;
                    while ((json = bufferedReader.readLine()) != null) {
                        sb.append(json + "\n");
                    }
                    message = sb.toString().trim();

                } catch (Exception ex) {
                    Log.v("async ex ", ex.getMessage());
                    ex.printStackTrace();
                }
            }
        }catch (Exception ex){
            Toast.makeText(context, ""+ex.getMessage(), Toast.LENGTH_SHORT).show();
        }
            return message;
        }

    @Override
    protected void onPostExecute(String result) {
        if (result.contains("agentstatus")) {
            this.getservList(result);
        }
        if (result.contains("issuersliststatus")) {
            this.issuersList(result);
        }
        if (result.contains("callforrange")) {
            Toast.makeText(context, "Reminder sent successfully.", Toast.LENGTH_SHORT).show();
        }if (result.contains("callfornext")) {
            if (result.contains("selectee")) {
                AlertDialog.Builder db = new AlertDialog.Builder(context);
                db.setTitle("Warning!!!");
                db.setMessage(""+result);
                db.setCancelable(false);
                db.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        Intent in=new Intent(context,Company_dashboard.class);
                        in.putExtra("uid",uid);
                        context.startActivity(in);

                    }
                });
                 db.show();
            }
            else{
                Toast.makeText(context, "Issuer accepted successfully" , Toast.LENGTH_SHORT).show();
            }
        }

    }

    private void issuersList(String result) {
        String res=result;
        Log.v("322222",res);
        // Toast.makeText(context,res,Toast.LENGTH_SHORT).show();
        JSONObject jObj = null;
        try {
            jObj = new JSONObject(res);
            JSONArray jsonArry = jObj.getJSONArray("issuersliststatus");

            if(jsonArry.length()==0 ){
                AlertDialog.Builder db = new AlertDialog.Builder(context);
                db.setTitle("Notification");
                db.setMessage("No issuer found.");
                db.setCancelable(false);
                db.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        Intent in=new Intent(context,Company_dashboard.class);
                        in.putExtra("uid",uid);
                        context.startActivity(in);
                    }
                });
                AlertDialog dialog = db.show();
            }
            Log.v("vvvvvvvv",jsonArry.length()+"");
            String action="live";
            issuers  = new ArrayList<issuer>();
            issuer is;
            for(int i = 0 ; i < jsonArry.length(); i ++){
                JSONObject jsonObject = jsonArry.getJSONObject(i);
                is=new issuer(jsonObject.getString("token")
                        ,jsonObject.getString("qid"),jsonObject.getString("issue_time"),
                        jsonObject.getString("number"),jsonObject.getString("number"));
                issuers.add(is);
            }
/*
            isadapter = new issuer_adapter(context, issuers,uid);
            coordlistview.setAdapter(isadapter);
            coordlistview.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                public void onItemClick(AdapterView<?> parent, View v, int position, long id) {
                    Log.v("5555555",issuers.get(position).getFname());
                    coordinator_async oassync=new coordinator_async(context, coordlistview, uid,sid);
                    oassync.execute("callforqueue",issuers.get(position).getUid(),sid,uid);
                }
            });*/
        } catch (JSONException e) {
              Log.v("888888888",e.getLocalizedMessage());
        }
    }
}
