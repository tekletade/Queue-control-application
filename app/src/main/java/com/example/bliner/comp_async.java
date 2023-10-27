package com.example.bliner;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;
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

public class comp_async extends AsyncTask<String,Void,String> {
    private Context context;
    private ArrayList<company> comps;
    private GridView officerlist;
    private String uid;

    public comp_async(Context company_dashboard, GridView gridview,String uid) {
        this.context=company_dashboard;
        this.officerlist=gridview;
        this.uid=uid;
    }

    @Override
    protected String doInBackground(String... arg0) {
        String message = "done";
        try {
            String action = (String) arg0[0];
            Log.v("eeettrrrreeee", action);
            if (action.equals("complist")) {
                String link = "https://liner12.000webhostapp.com/liner/manage_company.php";
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
        } catch (Exception ex) {
            Log.v("async ex ", ex.getMessage());
            ex.printStackTrace();
        }
        return message;
    }


    @Override
    protected void onPostExecute(String result) {
        if (result.contains("compstatus")) {
            this.getCompList(result);
        }

    }

    private void getCompList(String result) {
        String res=result;
       // Toast.makeText(context,res,Toast.LENGTH_SHORT).show();
        ArrayList<company> offlist=new ArrayList<>();
        JSONObject jObj = null;
        try {
            jObj = new JSONObject(res);
            JSONArray jsonArry = jObj.getJSONArray("compstatus");

            if(jsonArry.length()==0 ){
                AlertDialog.Builder db = new AlertDialog.Builder(context);
                db.setTitle("Notification");
                db.setMessage("No branch detail is available.Try an other branch.");
                db.setCancelable(false);
                db.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();

                        Intent in=new Intent(context,LoginActivity.class);
                        in.putExtra("uid",uid);
                        context.startActivity(in);

                    }
                });
                AlertDialog dialog = db.show();
            }
            Log.v("vvvvvvvv",jsonArry.length()+"");
            String action="live";
            comps  = new ArrayList<company>();company c;
            for(int i = 0 ; i < jsonArry.length(); i ++){
                JSONObject jsonObject = jsonArry.getJSONObject(i);
                c=new company(jsonObject.getString("cid"),jsonObject.getString("name"),
                        jsonObject.getString("branchname"),jsonObject.getString("location"),
                        jsonObject.getString("isbranch"));
                comps.add(c);
                Log.v("00000hh",jsonObject.toString());

            }
            dashboardAdapter oadapter=new dashboardAdapter(context,comps);
            officerlist.setAdapter(oadapter);
            officerlist.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                public void onItemClick(AdapterView<?> parent,
                                        View v, int position, long id){
                    // Send intent to SingleViewActivity
                    //  Intent i = new Intent(getApplicationContext(), CompActivity.class);
                    Intent i = new Intent(context, ServiceActivity.class);
                    i.putExtra("cid",comps.get(position).getCid());
                    i.putExtra("uid",uid);
                    context.startActivity(i);
                    // Pass image index
                    // i.putExtra("id", position);
                }
            });
        } catch (JSONException e) {
            Toast.makeText(context,e.getLocalizedMessage(),Toast.LENGTH_SHORT).show();
        }

    }

}
