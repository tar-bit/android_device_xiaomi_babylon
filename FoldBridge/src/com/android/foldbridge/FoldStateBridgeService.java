package com.android.foldbridge;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

public class FoldStateBridgeService extends Service implements SensorEventListener {

    private static final String TAG = "FoldStateBridge";
    private static final float FOLD_CLOSED_ANGLE = 30.0f;
    private static final float FOLD_OPENED_ANGLE = 150.0f;
    private static final String CHANNEL_ID = "fold_service";

    private static final int FOLD_STATE_CLOSED = 0;
    private static final int FOLD_STATE_HALF_OPENED = 2;
    private static final int FOLD_STATE_OPENED = 3;

    private SensorManager sensorManager;
    private Sensor hingeAngleSensor;
    private int lastState = -1;

    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(TAG, "Service created");

        createNotificationChannel();
        startForegroundServiceWithNotification();

        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        hingeAngleSensor = sensorManager.getDefaultSensor(Sensor.TYPE_HINGE_ANGLE);

        if (hingeAngleSensor != null) {
            sensorManager.registerListener(this, hingeAngleSensor, SensorManager.SENSOR_DELAY_NORMAL);
            Log.i(TAG, "Hinge angle sensor listener registered");
        } else {
            Log.e(TAG, "Hinge angle sensor not found");
        }
    }

    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel serviceChannel = new NotificationChannel(
                    CHANNEL_ID,
                    "FoldBridge Foreground Service",
                    NotificationManager.IMPORTANCE_LOW
            );
            NotificationManager manager = getSystemService(NotificationManager.class);
            if (manager != null) {
                manager.createNotificationChannel(serviceChannel);
            }
        }
    }

    private void startForegroundServiceWithNotification() {
        Notification notification = new Notification.Builder(this, CHANNEL_ID)
                .setContentTitle("FoldBridge Service")
                .setContentText("Monitoring hinge angle")
                .setSmallIcon(android.R.drawable.ic_menu_compass)
                .build();

        startForeground(1, notification); // Use classic method to maintain compatibility
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.i(TAG, "Service started");
        return START_STICKY;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (sensorManager != null && hingeAngleSensor != null) {
            sensorManager.unregisterListener(this, hingeAngleSensor);
            Log.i(TAG, "Sensor listener unregistered");
        }
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        float angle = event.values[0];
        int newState;

        if (angle < FOLD_CLOSED_ANGLE) {
            newState = FOLD_STATE_CLOSED;
        } else if (angle > FOLD_OPENED_ANGLE) {
            newState = FOLD_STATE_OPENED;
        } else {
            newState = FOLD_STATE_HALF_OPENED;
        }

        if (newState != lastState) {
            Log.i(TAG, "Detected fold state change: " + newState + ", angle=" + angle);
            lastState = newState;
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {}

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    public static class BootReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())) {
                Log.i(TAG, "Boot completed, starting FoldStateBridgeService");
                Intent serviceIntent = new Intent(context, FoldStateBridgeService.class);
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    context.startForegroundService(serviceIntent);
                } else {
                    context.startService(serviceIntent);
                }
            }
        }
    }
}

