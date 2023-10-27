package com.example.bliner;

public class service {

    private  String name,sid,coordinator;
    private  String total, current,status;

    public service(String s, String s1, String s3,String s2,String sid,String coordinator) {
        this.name=s;
        this.total=s1;
        this.current=s3;
        this.status=s2;
        this.sid=sid;
        this.coordinator=coordinator;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getCoordinator() {
        return coordinator;
    }

    public void setCoordinator(String coordinator) {
        this.coordinator = coordinator;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getCurrent() {
        return current;
    }

    public void setCurrent(String current) {
        this.current = current;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
