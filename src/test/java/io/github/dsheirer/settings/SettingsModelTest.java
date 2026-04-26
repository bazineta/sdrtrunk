package io.github.dsheirer.settings;

import org.junit.jupiter.api.Test;
import java.awt.Color;
import static org.junit.jupiter.api.Assertions.*;

public class SettingsModelTest {

    @Test
    public void testColorSetting() {
        SettingsModel model = new SettingsModel();
        ColorSetting.ColorSettingName name = ColorSetting.ColorSettingName.SPECTRUM_LINE;

        Color initialColor = model.getColorSetting(name).getColor();
        assertEquals(new Color(name.getDefaultColor().getRed(), name.getDefaultColor().getGreen(), name.getDefaultColor().getBlue(), name.getTranslucency()), initialColor);

        Color newColor = Color.RED;
        model.setColorSetting(name, newColor);

        assertEquals(new Color(newColor.getRed(), newColor.getGreen(), newColor.getBlue(), name.getTranslucency()), model.getColorSetting(name).getColor());
    }

    @Test
    public void testListener() {
        SettingsModel model = new SettingsModel();
        final boolean[] changed = {false};

        model.addListener(new SettingChangeListener() {
            @Override
            public void settingChanged(Setting setting) {
                changed[0] = true;
            }

            @Override
            public void settingDeleted(Setting setting) {
            }
        });

        model.setColorSetting(ColorSetting.ColorSettingName.SPECTRUM_LINE, Color.BLUE);
        assertTrue(changed[0]);
    }
}
