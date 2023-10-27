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

public class issuer_async extends AsyncTask<String,Void,String> {
    Context context;
    String uid,gcid;
    ListView servicelist;
    private issuer_adapter adapter;
    LinearLayout ln;

    Button shiftbtn,leavebtn,issuebtn;
    private ArrayList<issuedlist> issuedlistDetail;

    public issuer_async(Context context, ListView listView, String uid, String gcid, LinearLayout ln, Button shiftbtn, Button leavebtn, Button issuebtn) {
        this.context = context;
        this.uid = uid;
        this.gcid = gcid;
        this.servicelist = listView;
        this.ln=ln;
        this.issuebtn=issuebtn;
        this.leavebtn=leavebtn;
        this.shiftbtn=shiftbtn;
    }
    @Override
    protected String doInBackground(String... strings) {
        String message = "done";
        try {
            String action = (String) strings[0];
            Log.v("eeettrrrreeee", action);
            if (action.equals("issuedlist")) {
                String uuid = (String) strings[1];
                String link = "https://liner12.000webhostapp.com/liner/manage_queue.php?byuid="+uuid;
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

        } catch (Exception ex) {
            Log.v("async ex ", ex.getMessage());
            ex.printStackTrace();
        }
        return message;
    }

    @Override
    protected void onPostExecute(String result) {
        if (result.contains("issuedliststatus")) {
            this.getissuedList(result);
        }
        if(result.contains("More than one chance") || result.contains("Shifted successfully") ){
            AlertDialog.Builder db = new AlertDialog.Builder(context);
            db.setTitle("Notification");
            db.setMessage(""+result);
            db.setCancelable(false);
            db.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int which) {
                    Intent in=new Intent(context,Company_dashboard.class);
                    in.putExtra("uid",uid);
                    context.startActivity(in);

                }
            });
            AlertDialog dialog = db.show();
            ln.setVisibility(View.INVISIBLE);
        }
        if (result.contains("left")){

        }

    }

    private void getissuedList(String result) {
        String res=result;
        // Toast.makeText(context,res,Toast.LENGTH_SHORT).show();
        ArrayList<issuer> offlist=new ArrayList<>();
        JSONObject jObj = null;
        try {
            jObj = new JSONObject(res);
            JSONArray jsonArry = jObj.getJSONArray("issuedliststatus");
            Log.v("iiiiiiiiiiiyyi",jsonArry.toString()+"");

            if(jsonArry.length()==0 ){
                AlertDialog.Builder db = new AlertDialog.Builder(context);
                db.setTitle("Notification");
                db.setMessage("Not issued to a service yet.");
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
            String nexts="";
            Log.v("iiiiiiiiiiii",jsonArry.length()+"");
            String action="live";
            issuedlistDetail  = new ArrayList<issuedlist>();
            issuedlist s;
            for(int i = 0 ; i < jsonArry.length(); i ++){
                JSONObject jsonObject = jsonArry.getJSONObject(i);
                JSONObject obj2=new JSONObject(jsonObject.getString("0"));
                JSONObject obj3=new JSONObject(jsonObject.getString("1")); nexts="";
                if(!obj3.isNull("next")){
                    JSONArray jsonArry2 = obj3.getJSONArray("next");
                    Log.v("iiiiooooiii3",jsonArry2.toString()+ "  "+jsonArry2.length());
                   if (jsonArry2.length()>1) {
                       for (int j = 0; j < jsonArry2.length(); j++) {
                           nexts += jsonArry2.getJSONObject(j).getString("number") + ",";
                       }
                   }
                   else
                       nexts=obj3.getString("next")+",";
                    if(nexts.length()!=0)
                        nexts=nexts.substring(0,nexts.length()-1);
                }
                if(nexts.contains("[") || nexts.contains("]")) {
                    nexts = nexts.replace("[", "");
                    nexts = nexts.replace("]", "");
                }
                if(nexts.equalsIgnoreCase(jsonObject.getString("number"))){
                    nexts="You";
                }
                Log.v("iiiiooooiii",obj2.getString("offset"));
                s=new issuedlist(jsonObject.getString("servicename"),jsonObject.getString("companyname"),
                        jsonObject.getString("cid"),jsonObject.getString("sid")
                        ,jsonObject.getString("qid"),jsonObject.getString("issue_time"),jsonObject.getString("token")
                        ,jsonObject.getString("state"),nexts,obj2.getString("offset")
                        ,jsonObject.getString("number"));
                issuedlistDetail.add(s);
                Log.v("00000hssssh",jsonObject.getString("0"));

            }

            adapter = new issuer_adapter(context, issuedlistDetail,uid);
            servicelist.setAdapter(adapter);
            servicelist.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                public void onItemClick(AdapterView<?> parent,
                                        View v, int position, long id) {

                    if(ln.getVisibility()==View.INVISIBLE) {
                        ln.setVisibility(View.VISIBLE);

                        shiftbtn.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                service_async asyncs=new service_async(context,null,uid,gcid, ln, shiftbtn, leavebtn);
                                asyncs.execute("shiftQ","",uid,issuedlistDetail.get(position).getSid(),uid,"0");
                            }
                        });
                        leavebtn.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View v) {
                                try {
                                    service_async asyncs=new service_async(context,null,uid,gcid, ln, shiftbtn, leavebtn);
                                    asyncs.execute("leaveQ",issuedlistDetail.get(position).getSid(),uid,"android");
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        });
                    }

                }
            });
        } catch (JSONException e) {
            Toast.makeText(context,e.getLocalizedMessage(),Toast.LENGTH_SHORT).show();
        }
    }
}
