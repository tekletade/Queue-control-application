package com.example.bliner;

public class issuer {
    String uid,fname,lname,phone, current,remaining,state,qid;

    public issuer(String uid, String fname, String phone, String current, String remaining) {
        this.uid = uid;
        this.fname = fname;
        this.phone = phone;
        this.current = current;
        this.remaining = remaining;
    }

    public issuer(String uid, String fname, String lname, String phone, String current, String remaining, String state, String qid) {
        this.uid = uid;
        this.fname = fname;
        this.lname = lname;
        this.phone = phone;
        this.current = current;
        this.remaining = remaining;
        this.state = state;
        this.qid = qid;
    }

    public issuer() {
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getQid() {
        return qid;
    }

    public void setQid(String qid) {
        this.qid = qid;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCurrent() {
        return current;
    }

    public void setCurrent(String current) {
        this.current = current;
    }

    public String getRemaining() {
        return remaining;
    }

    public void setRemaining(String remaining) {
        this.remaining = remaining;
    }
}
