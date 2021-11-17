package com.example.sunmi_basic_example;

import android.os.Bundle;
import android.os.RemoteException;
import android.widget.Button;
import woyou.aidlservice.jiuiv5.IWoyouService;
import woyou.aidlservice.jiuiv5.ICallback;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    Button drucken, kasse, secScreen;
    IWoyouService sunmiService;
    ICallback callback;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        init();
        this.drucken.setOnClickListener(view -> {

        });
        this.kasse.setOnClickListener(view -> {
            try {
                sunmiService.openDrawer(null);
            } catch (RemoteException e) {
                e.printStackTrace();
            }
        });
        this.drucken.setOnClickListener(view -> {

        });
    }

    protected  void init(){
        this.drucken = findViewById(R.id.btnPrint);
        this.kasse = findViewById(R.id.btnCashbox);
        this.secScreen = findViewById(R.id.btnSecScreen);

    }
}