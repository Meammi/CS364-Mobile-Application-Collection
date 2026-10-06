package com.example.weekendplanner;

import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.os.Bundle;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.SwitchCompat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    EditText editActivity;
    AutoCompleteTextView autoLocation;
    RadioGroup radioGroup;

    CheckBox checkWater;
    CheckBox checkCamera;
    CheckBox checkSnacks;

    Spinner spinnerBudget;
    SwitchCompat switchReminder;

    Button buttonDate;
    Button buttonTime;
    Button buttonCreate;

    RatingBar ratingBar;
    TextView textResult;

    Calendar selectedDate = Calendar.getInstance();

    int selectedHour = 10;
    int selectedMinute = 0;

    String selectedDateText = "";
    String selectedTimeText = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Auto Complete

        editActivity = findViewById(R.id.edit_activity);
        autoLocation = findViewById(R.id.auto_location);
        radioGroup = findViewById(R.id.radio_group);

        checkWater = findViewById(R.id.check_water);
        checkCamera = findViewById(R.id.check_camera);
        checkSnacks = findViewById(R.id.check_snacks);

        spinnerBudget = findViewById(R.id.spinner_budget);
        switchReminder = findViewById(R.id.switch_reminder);

        buttonDate = findViewById(R.id.button_date);
        buttonTime = findViewById(R.id.button_time);
        buttonCreate = findViewById(R.id.button_create);

        ratingBar = findViewById(R.id.rating_bar);
        textResult = findViewById(R.id.text_result);


        // AutoCompleteTextView
        String[] locations = getResources().getStringArray(R.array.location_options);
        ArrayAdapter<String> locationAdapter = new ArrayAdapter<>(
                this,
                android.R.layout.simple_dropdown_item_1line,
                locations
        );
        autoLocation.setAdapter(locationAdapter);
        autoLocation.setThreshold(1);

        // Spinner
        ArrayAdapter<CharSequence> budgetAdapter = ArrayAdapter.createFromResource(
                this,
                R.array.budget_options,
                android.R.layout.simple_spinner_item
        );
        budgetAdapter.setDropDownViewResource(android.R.layout.simple_list_item_checked);
        spinnerBudget.setAdapter(budgetAdapter);

        // Button events
        buttonDate.setOnClickListener(
                v -> showDatePicker()
        );
        buttonTime.setOnClickListener(
                v -> showTimePicker()
        );
        buttonCreate.setOnClickListener(
                v -> createPlan()
        );
    }//end onCreate

    private void showDatePicker() {
        DatePickerDialog dialog =
                new DatePickerDialog(
                        this,
                        (view, year, month, day) -> {
                            selectedDate.set(
                                    year,
                                    month,
                                    day
                            );
                            SimpleDateFormat f =
                                    new SimpleDateFormat(
                                            "EEE, MMM d, yyyy",
                                            Locale.getDefault()
                                    );
                            selectedDateText =
                                    f.format(
                                            selectedDate.getTime()
                                    );
                            buttonDate.setText(
                                    selectedDateText
                            );
                        },
                        selectedDate.get(Calendar.YEAR),
                        selectedDate.get(Calendar.MONTH),
                        selectedDate.get(Calendar.DAY_OF_MONTH)
                );
        dialog.show();
    }

    private void showTimePicker() {
        TimePickerDialog dialog =
                new TimePickerDialog(
                        this,
                        (view, hour, minute) -> {
                            selectedHour = hour;
                            selectedMinute = minute;
                            Calendar time = Calendar.getInstance();
                            time.set(
                                    Calendar.HOUR_OF_DAY,
                                    hour
                            );
                            time.set(
                                    Calendar.MINUTE,
                                    minute
                            );
                            SimpleDateFormat f =
                                    new SimpleDateFormat(
                                            "h:mm a",
                                            Locale.getDefault()
                                    );
                            selectedTimeText =
                                    f.format(
                                            time.getTime()
                                    );
                            buttonTime.setText(
                                    selectedTimeText
                            );
                        },
                        selectedHour,
                        selectedMinute,
                        false
                );
        dialog.show();
    }

    private void createPlan() {
        String activity = editActivity.getText().toString().trim();
        String location = autoLocation.getText().toString().trim();

        // Validate Activity Name
        if (activity.isEmpty()) {
            editActivity.setError(
                    getString(R.string.required)
            );
            editActivity.requestFocus();
            return;
        }

        // Validate Location
        if (location.isEmpty()) {
            autoLocation.setError(
                    getString(R.string.required)
            );
            autoLocation.requestFocus();
            return;
        }

        // RadioButton
        String type = getString(R.string.not_selected);
        int checkId = radioGroup.getCheckedRadioButtonId();
        if(checkId != -1){
            RadioButton radioButton = findViewById(checkId);
            type = radioButton.getText().toString();
        }

        // CheckBox
        StringBuilder bring  = new StringBuilder();
        if(checkWater.isChecked()){
            bring.append("Water");
        }
        if(checkCamera.isChecked()){
            addComma(bring, "Camera");
        }
        if(checkSnacks.isChecked()){
            addComma(bring, "Snakes");
        }
        if(bring.length()==0){
            bring.append(getString(R.string.none));
        }

        // Spinner
        String budget = spinnerBudget.getSelectedItem().toString();

        // Switch
        String reminder = switchReminder.isChecked()
                ? getString(R.string.on) : getString(R.string.off);

        // RatingBar
        float rating = ratingBar.getRating();

        // Date
        String date = selectedDateText.isEmpty()
                ? getString(R.string.not_selected) : selectedDateText;

        // Time
        String time = selectedTimeText.isEmpty()
                ? getString(R.string.not_selected) : selectedTimeText;

        // Create result
        String result = getString(
                R.string.plan_result,
                activity,
                location,
                type,
                date,
                time,
                budget,
                reminder,
                bring.toString(),
                rating
        );

        // Display result
        textResult.setText(result);

        // Toast
        Toast.makeText(
                this,
                R.string.plan_created,
                Toast.LENGTH_SHORT
        ).show();
    }//end createPlan

    private void addComma(
            StringBuilder text,
            String value
    ) {
        if (text.length() > 0) {
            text.append(", ");
        }
        text.append(value);
    }
}//end MainActivity