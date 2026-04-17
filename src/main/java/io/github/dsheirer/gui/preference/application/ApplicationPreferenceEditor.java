/*
 * *****************************************************************************
 * Copyright (C) 2014-2024 Dennis Sheirer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 * ****************************************************************************
 */

package io.github.dsheirer.gui.preference.application;

import io.github.dsheirer.preference.UserPreferences;
import io.github.dsheirer.preference.application.ApplicationPreference;
import javafx.geometry.Insets;
import javafx.scene.control.Label;
import javafx.scene.control.Spinner;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Priority;
import javafx.scene.layout.VBox;
import org.controlsfx.control.ToggleSwitch;

/**
 * Preference settings for application
 */
public class ApplicationPreferenceEditor extends HBox
{
    private ApplicationPreference mApplicationPreference;
    private VBox mEditorPane;
    private Label mAutoStartTimeoutLabel;
    private Spinner<Integer> mTimeoutSpinner;
    private Label mMemoryLimitLabel;
    private Spinner<Integer> mMemorySpinner;
    private Label mMemoryWarningLabel;
    private ToggleSwitch mAutomaticDiagnosticMonitoringToggle;

    /**
     * Constructs an instance
     * @param userPreferences for obtaining reference to preference.
     */
    public ApplicationPreferenceEditor(UserPreferences userPreferences)
    {
        mApplicationPreference = userPreferences.getApplicationPreference();
        setMaxWidth(Double.MAX_VALUE);

        VBox vbox = new VBox();
        vbox.setMaxHeight(Double.MAX_VALUE);
        vbox.setMaxWidth(Double.MAX_VALUE);
        vbox.getChildren().add(getEditorPane());
        HBox.setHgrow(vbox, Priority.ALWAYS);
        getChildren().add(vbox);
    }

    private VBox getEditorPane()
    {
        if(mEditorPane == null)
        {
            mEditorPane = new VBox(20);
            mEditorPane.setMaxWidth(Double.MAX_VALUE);
            mEditorPane.setPadding(new Insets(10, 10, 10, 10));

            // Card 1: Diagnostic Monitoring
            VBox diagCard = new VBox(10);
            diagCard.getStyleClass().add("preferences-card");
            Label monitoringLabel = new Label("Application Health and Diagnostic Monitoring.");
            monitoringLabel.setStyle("-fx-font-weight: bold; -fx-text-fill: #333333;");

            HBox diagRow = new HBox(10);
            diagRow.getStyleClass().add("preferences-card-row");
            diagRow.setAlignment(javafx.geometry.Pos.CENTER_LEFT);
            Label enableDiagLabel = new Label("Enable Diagnostic Monitoring");
            javafx.scene.layout.Region spacer1 = new javafx.scene.layout.Region();
            HBox.setHgrow(spacer1, Priority.ALWAYS);
            diagRow.getChildren().addAll(enableDiagLabel, spacer1, getAutomaticDiagnosticMonitoringToggle());

            diagCard.getChildren().addAll(monitoringLabel, diagRow);

            // Card 2: Auto Start
            VBox autoStartCard = new VBox(10);
            autoStartCard.getStyleClass().add("preferences-card");

            HBox autoStartRow = new HBox(10);
            autoStartRow.getStyleClass().add("preferences-card-row");
            autoStartRow.setAlignment(javafx.geometry.Pos.CENTER_LEFT);
            javafx.scene.layout.Region spacer2 = new javafx.scene.layout.Region();
            HBox.setHgrow(spacer2, Priority.ALWAYS);

            HBox spinnerBox = new HBox(5);
            spinnerBox.setAlignment(javafx.geometry.Pos.CENTER_LEFT);
            spinnerBox.getChildren().addAll(getTimeoutSpinner(), new Label("seconds"));

            autoStartRow.getChildren().addAll(getAutoStartTimeoutLabel(), spacer2, spinnerBox);
            autoStartCard.getChildren().addAll(autoStartRow);

            // Card 3: Memory Limit
            VBox memoryCard = new VBox(10);
            memoryCard.getStyleClass().add("preferences-card");

            HBox memoryRow = new HBox(10);
            memoryRow.getStyleClass().add("preferences-card-row");
            memoryRow.setAlignment(javafx.geometry.Pos.CENTER_LEFT);
            javafx.scene.layout.Region spacer3 = new javafx.scene.layout.Region();
            HBox.setHgrow(spacer3, Priority.ALWAYS);

            HBox memSpinnerBox = new HBox(5);
            memSpinnerBox.setAlignment(javafx.geometry.Pos.CENTER_LEFT);
            memSpinnerBox.getChildren().addAll(getMemorySpinner(), new Label("GB"));

            memoryRow.getChildren().addAll(getMemoryLimitLabel(), spacer3, memSpinnerBox);

            getMemoryWarningLabel().setStyle("-fx-text-fill: #8e8e93; -fx-font-size: 12px;");
            memoryCard.getChildren().addAll(memoryRow, getMemoryWarningLabel());

            mEditorPane.getChildren().addAll(diagCard, autoStartCard, memoryCard);
        }

        return mEditorPane;
    }

    private Label getAutoStartTimeoutLabel()
    {
        if(mAutoStartTimeoutLabel == null)
        {
            mAutoStartTimeoutLabel = new Label("Channel Auto-start Disable Timeout");
        }

        return mAutoStartTimeoutLabel;
    }

    private Spinner<Integer> getTimeoutSpinner()
    {
        if(mTimeoutSpinner == null)
        {
            mTimeoutSpinner = new Spinner<>(0, 30, mApplicationPreference.getChannelAutoStartTimeout(), 1);
            mTimeoutSpinner.valueProperty().addListener((observable, oldValue, newValue) -> mApplicationPreference.setChannelAutoStartTimeout(newValue));
        }

        return mTimeoutSpinner;
    }

    /**
     * Toggle switch to enable/disable automatic diagnostic monitoring.
     */
    private ToggleSwitch getAutomaticDiagnosticMonitoringToggle()
    {
        if(mAutomaticDiagnosticMonitoringToggle == null)
        {
            mAutomaticDiagnosticMonitoringToggle = new ToggleSwitch();
            mAutomaticDiagnosticMonitoringToggle.setSelected(mApplicationPreference.isAutomaticDiagnosticMonitoring());
            mAutomaticDiagnosticMonitoringToggle.selectedProperty().addListener((observable, oldValue, enabled) ->
                    mApplicationPreference.setAutomaticDiagnosticMonitoring(enabled));
        }

        return mAutomaticDiagnosticMonitoringToggle;
    }
    private Label getMemoryLimitLabel()
    {
        if(mMemoryLimitLabel == null)
        {
            mMemoryLimitLabel = new Label("Allocated Memory");
        }

        return mMemoryLimitLabel;
    }

    private Spinner<Integer> getMemorySpinner()
    {
        if(mMemorySpinner == null)
        {
            mMemorySpinner = new Spinner<>(1, 64, mApplicationPreference.getAllocatedMemory(), 1);
            mMemorySpinner.valueProperty().addListener((observable, oldValue, newValue) -> mApplicationPreference.setAllocatedMemory(newValue));
        }

        return mMemorySpinner;
    }

    private Label getMemoryWarningLabel()
    {
        if(mMemoryWarningLabel == null)
        {
            mMemoryWarningLabel = new Label("A restart of SDRTrunk is required for this setting to take effect.");
        }

        return mMemoryWarningLabel;
    }
}
