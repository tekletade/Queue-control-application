package com.example.bliner;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;

public class company_adapter  extends BaseAdapter {
    private Context context;
    private ArrayList<service> arrayList;
    private TextView name, total, current;
    public company_adapter(Context context, ArrayList<service> arrayList) {
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
        total.setText(" fg" );
        name.setText(arrayList.get(position).getName());
        current.setText("arrayList.get(position).getCurrent()");
        return convertView;
    }
}