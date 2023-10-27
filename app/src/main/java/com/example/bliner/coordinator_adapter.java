package com.example.bliner;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CompoundButton;
import android.widget.ListView;
import android.widget.Switch;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

import okhttp3.MediaType;

public class coordinator_adapter extends BaseAdapter {
    private final String uid;
    private Context context;
    private ArrayList<coordinator> arrayList;
    private TextView name, total, current;
    private Switch switchbtn;
    private TextView status;
    public String url= "https://liner12.000webhostapp.com/liner/manage_service.php";
    public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private TextView sidview;
    private String  sid,cid;
    private ListView colist;

    public coordinator_adapter(Context context, ArrayList<coordinator> arrayList,String uid,String cid) {
        this.context = context;
        this.arrayList = arrayList;
        this.uid=uid;
        this.cid=cid;
    }
    @Override
    public int getCount() {
        return arrayList.size();
    }
    @Override
    public Object getItem(int position) {
        return position;
    }
    @Override
    public long getItemId(int position) {
        return position;
    }
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        convertView = LayoutInflater.from(context).inflate(R.layout.agentlistrow, parent, false);
        //convertView.setBackgroundColor(Color.WHITE);
       final View convertView1 = convertView;

        name = convertView.findViewById(R.id.name);
        sidview = convertView.findViewById(R.id.sid);
        switchbtn=convertView.findViewById(R.id.switch1);
        name.setPadding(20,5,0,0);
        sidview.setPadding(20,5,0,0);
        name.setText(arrayList.get(position).getName());

        if (arrayList.get(position).getState().contains("Not started")){
            switchbtn.setChecked(false);
            sidview.setText(""+arrayList.get(position).getState());
            convertView.setBackgroundColor(Color.YELLOW);
        }else {
            switchbtn.setChecked(true);
           sidview.setText("Started on: "+arrayList.get(position).getState());
            convertView.setOnTouchListener(new View.OnTouchListener() {
                @Override
                public boolean onTouch(View v, MotionEvent event) {
                    Log.v("77777",arrayList.get(position).getName());
                    try {
                        Intent in = new Intent(context.getApplicationContext()
                                , ScannedBarcodeActivity.class);
                        in.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        in.putExtra("sid", arrayList.get(position).getSid());
                        in.putExtra("coordinator", arrayList.get(position).getCoordinator());
                        in.putExtra("gcid",cid);
                        in.putExtra("sname",arrayList.get(position).getName());
                        in.putExtra("total",arrayList.get(position).getTotalwaiters());
                        in.putExtra("nextw",arrayList.get(position).getNextwaiters());
                        context.getApplicationContext().startActivity(in);
                    }catch (Exception ex){
                        Log.d("uuuuuuuuu", "onTouch: "+ex.getLocalizedMessage());
                        ex.printStackTrace();
                    }
                    return false;
                }
            });
        }

        switchbtn.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                Log.v("Switch State=", arrayList.get(position).getSid()+" :: "+isChecked);
            if (isChecked) {
                String postBody = "{\n" +
                        "    \"sid\": \"" + arrayList.get(position).getSid() + "\",\n" +
                        "    \"startqsession\": \"test\"\n" +
                        "}";
                try {
                    coordinator_async oassync=new coordinator_async(context, colist, uid,cid);
                    oassync.execute("sessionstatus",uid,arrayList.get(position).getSid(),"startqsession");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }else{
                try {
                    coordinator_async oassync=new coordinator_async(context, colist, uid,cid);
                    oassync.execute("sessionstatus",uid,arrayList.get(position).getSid(),"stopqsession");
                } catch (Exception e) {
                    e.printStackTrace();
                }
}
            }
        });
        return convertView;
    }

}