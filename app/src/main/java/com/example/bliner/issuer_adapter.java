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

import java.util.ArrayList;

import okhttp3.MediaType;

public class issuer_adapter extends BaseAdapter {
    private final String uid;
    private Context context;
    private ArrayList<issuedlist> arrayList;
    private TextView name, total, current;
    private Switch switchbtn;
    private TextView status;
    public String url= "https://liner12.000webhostapp.com/liner/manage_service.php";
    public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private TextView sid;
    private TextView offset,number;
    private TextView issue_time;

    public issuer_adapter(Context context, ArrayList<issuedlist> arrayList,String uid) {
        this.context = context;
        this.arrayList = arrayList;
        this.uid=uid;
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
        convertView = LayoutInflater.from(context).inflate(R.layout.issuerlistview, parent, false);
        //convertView.setBackgroundColor(Color.WHITE);

        name = convertView.findViewById(R.id.servicename);
        ((TextView)name.findViewById(R.id.servicename)).setTextColor(Color.RED); // here can be your logic

        offset = convertView.findViewById(R.id.offset);
        number = convertView.findViewById(R.id.number);
        issue_time = convertView.findViewById(R.id.issued_time);

        name.setPadding(20,0,0,0);
        name.setText(arrayList.get(position).getServicename());
        offset.setText("Remaining: "+arrayList.get(position).getStatus());
        number.setText("You are: "+arrayList.get(position).getNumber()+"\nNext: "+arrayList.get(position).getChannel());
        issue_time.setText("Booked on: "+arrayList.get(position).getIssue_time());
        return convertView;
    }

}