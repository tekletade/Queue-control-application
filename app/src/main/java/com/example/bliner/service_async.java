package com.example.bliner;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

public class service_async extends AsyncTask<String,Void,String> {
    Context context;
    String uid,gcid;
    ListView servicelist;
    private ArrayList<service> services;
    private serviceAdapter adapter;
    LinearLayout ln;

    Button issuebtn,issueforother;
    public service_async(Context context, ListView listView, String uid, String gcid, LinearLayout ln, Button shiftbtn, Button leavebtn) {
        this.context = context;
        this.uid = uid;
        this.gcid = gcid;
        this.servicelist = listView;
        this.ln=ln;
        this.issuebtn=shiftbtn;
        this.issueforother=leavebtn;
    }

    private void getservList(String result) {
        String res=result;
       // Toast.makeText(context,res,Toast.LENGTH_SHORT).show();
        ArrayList<company> offlist=new ArrayList<>();
        JSONObject jObj = null;
        try {
            jObj = new JSONObject(res);
            JSONArray jsonArry = jObj.getJSONArray("servstatus");

            if(jsonArry.length()==0 ){
                AlertDialog.Builder db = new AlertDialog.Builder(context);
                db.setTitle("Notification");
                db.setMessage("No service list is available.Try an other organization.");
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
            Log.v("vvvvvvvv",jsonArry.length()+"");
            String action="live";
            services  = new ArrayList<service>();
            service s;
            for(int i = 0 ; i < jsonArry.length(); i ++){
                JSONObject jsonObject = jsonArry.getJSONObject(i);
                s=new service(jsonObject.getString("name"),jsonObject.getString("total"),
                        jsonObject.getString("current"),jsonObject.getString("status")
                        ,jsonObject.getString("sid"),jsonObject.getString("coordinator"));
                services.add(s);
                Log.v("00000hssssh",jsonObject.toString());

            }

            adapter = new serviceAdapter(context, services);
            servicelist.setAdapter(adapter);
            servicelist.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                public void onItemClick(AdapterView<?> parent,
                                        View v, int position, long id) {

                    if(!services.get(position).getStatus().contains("Not started")) {
                        if (ln.getVisibility() == View.INVISIBLE) {
                            ln.setVisibility(View.VISIBLE);
                            issuebtn.setVisibility(View.VISIBLE);
                            issueforother.setOnClickListener(new View.OnClickListener() {
                                @Override
                                public void onClick(View view) {
                                    Intent in = new Intent(context, Issue_ForOther_Activity.class);
                                    in.putExtra("sid", services.get(position).getSid());
                                    in.putExtra("cid", gcid);
                                    in.putExtra("coordinator", uid);
                                    in.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                                    context.startActivity(in);
                                }
                            });
                            issuebtn.setOnClickListener(new View.OnClickListener() {
                                @Override
                                public void onClick(View v) {
                                    try {
                                        service_async asyncs = new service_async(context, null, uid, gcid, ln, issuebtn, issueforother);
                                        asyncs.execute("set_queue", services.get(position).getSid(), uid, "android");
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                }
                            });

                        }
                        Toast.makeText(context, position + "   " + id, Toast.LENGTH_SHORT).show();
                    }
                }
            });
        } catch (JSONException e) {
            Toast.makeText(context,e.getLocalizedMessage(),Toast.LENGTH_SHORT).show();
        }

    }

    @Override
    protected String doInBackground(String... strings) {
        String message = "done";
        try {
            String action = (String) strings[0];
            Log.v("eeettrrrreeee", action);
            if (action.equals("servlist")) {
                String gcid = (String) strings[1];
                String link = "https://liner12.000webhostapp.com/liner/manage_service.php?gcid="+gcid;
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
            }
            //GET['qid'],$_GET['uid'],$_GET['sid'],$_GET['number'

            else if(action.equalsIgnoreCase("shiftQ")){
                String qid = (String) strings[1];
                String uuid = (String) strings[2];
                String sid = (String) strings[3];
                String number = (String) strings[4];
                String link = "https://liner12.000webhostapp.com/liner/manage_queue.php?shiftQ=&uid="+uuid
                        +"&number=0&qid="+qid+"&sid="+sid;
                // String link = "http://192.168.0.2:8050/shells/register.php?fname=3&lname=4&phone=545&pin=6&phoneinfo=phoneinfo";
                Log.v("eeeeeeesssss", link);
                URL url = new URL(link);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                StringBuilder sb = new StringBuilder();
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String json;
                while ((json = bufferedReader.readLine()) != null) {
                    sb.append(json + "\n");
                }
                message = sb.toString().trim();
                //  Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
            }
            else if(action.equalsIgnoreCase("leaveQ")){
                String qid = (String) strings[1];
                String uuid = (String) strings[2];
                String sid = (String) strings[3];
                String number = (String) strings[4];
                AlertDialog.Builder db = new AlertDialog.Builder(context);
                db.setTitle("Warning");
                db.setMessage("Are you sure?");
                db.setCancelable(false);
                db.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                       dialog.dismiss();
                    }
                });
                AlertDialog dialog = db.show();
                //  Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
            }
            else if(action.equalsIgnoreCase("set_queue")){
                String sid = (String) strings[1];
                String uidd = (String) strings[2];
                String channel = (String) strings[3];
                String link = "https://liner12.000webhostapp.com/liner/manage_queue.php?token="+uidd+"&channel=android&sid="+sid;
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
              //  Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
            }
        } catch (Exception ex) {
            Log.v("async ex ", ex.getMessage());
            ex.printStackTrace();
        }
        return message;
    }

    @Override
    protected void onPostExecute(String result) {
        if (result.contains("servstatus")) {
            this.getservList(result);
        }
        else if(result.contains("queue_set")){
            Toast.makeText(context.getApplicationContext(), result,Toast.LENGTH_LONG).show();
            showdialog("Added successfully. Please be on time.");
            ln.setVisibility(View.INVISIBLE);
        }
        else if(result.contains("callforrange")){
//            String res=result.replace("callforrange","");
            showdialog("Notified successfully");
        }
        else if(result.contains("shiftdetail")){
            //String res=result.replace("callfornext","");
            showdialog(result);
        }

    }
    private void showdialog(String message){
        AlertDialog.Builder db = new AlertDialog.Builder(context);
        db.setTitle("Successful");
        db.setMessage(""+message);
        db.setCancelable(false);
        db.setPositiveButton("OK", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        db.show();
    }
}
