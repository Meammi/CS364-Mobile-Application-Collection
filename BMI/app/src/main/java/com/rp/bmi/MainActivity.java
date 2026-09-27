package com.rp.bmi;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import java.text.DecimalFormat;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        EditText edit_weight = findViewById(R.id.edit_weight);
        EditText edit_height = findViewById(R.id.edit_height);

        TextView edit_bmi = findViewById(R.id.edit_bmi);
        TextView edit_status = findViewById(R.id.edit_status);

        Button buttonCal = findViewById(R.id.button_cal);

        buttonCal.setOnClickListener(v -> {
            String weight_text = edit_weight.getText().toString();
            String height_text = edit_height.getText().toString();

            double weight = Double.parseDouble(weight_text);
            double height = Double.parseDouble(height_text);

            double height_meter = height / 100;

            double bmi = weight / (height_meter * height_meter);

            bmi = Math.ceil(bmi * 100) / 100.0;
            DecimalFormat formatter = new DecimalFormat("#,##0.00");
            edit_bmi.setText(formatter.format(bmi));

            if (bmi < 18.5) {
                edit_status.setText(R.string.underweight);
                edit_status.setTextColor(getColor(R.color.status_underweight));
            } else if (bmi < 25) {
                edit_status.setText(R.string.normal);
                edit_status.setTextColor(getColor(R.color.status_normal));
            } else if (bmi < 30) {
                edit_status.setText(R.string.overweight);
                edit_status.setTextColor(getColor(R.color.status_overweight));
            } else {
                edit_status.setText(R.string.obese);
                edit_status.setTextColor(getColor(R.color.status_obese));
            }
        });
    }
}