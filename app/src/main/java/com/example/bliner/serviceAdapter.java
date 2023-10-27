package com.example.bliner;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;

public class serviceAdapter extends BaseAdapter {
    private Context context;
    private ArrayList<service> arrayList;
    private TextView name, total, current;
    private TextView status;

    public serviceAdapter(Context context, ArrayList<service> arrayList) {
        this.context = context;
        this.arrayList = arrayList;
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
        convertView = LayoutInflater.from(context).inflate(R.layout.row, parent, false);
        name = convertView.findViewById(R.id.name);
        total = convertView.findViewById(R.id.total);
        current = convertView.findViewById(R.id.current);
        status = convertView.findViewById(R.id.status);
        name.setText(arrayList.get(position).getName());
        total.setText("Total: "+arrayList.get(position).getTotal() );
        if(!arrayList.get(position).getTotal().equals("0")) {
            current.setText("Next: " + arrayList.get(position).getCurrent());
        }
        if(arrayList.get(position).getStatus().contains("Not started")){
            status.setBackgroundColor(Color.YELLOW);
            status.setText("Status: "+arrayList.get(position).getStatus());
            convertView.setClickable(false);
        }
        else{
            status.setBackgroundColor(Color.GREEN);
            status.setText("Started on: "+arrayList.get(position).getStatus());
        }
        return convertView;
    }
}