/*
 *
 * Copyright 2016 EUROPEAN COMMISSION
 *
 * Licensed under the EUPL, Version 1.1 or – as soon they
 * will be approved by the European Commission - subsequent
 * versions of the EUPL (the "Licence");
 *
 * You may not use this work except in compliance with the Licence.
 *
 * You may obtain a copy of the Licence at:
 *
 * https://joinup.ec.europa.eu/community/eupl/og_page/eupl
 *
 * Unless required by applicable law or agreed to in
 * writing, software distributed under the Licence is
 * distributed on an "AS IS" basis,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied.
 * See the Licence for the specific language governing
 * permissions and limitations under the Licence.
 *
 */

package eu.europa.ec.grow.espd.edm.xml;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 * Created by vigi on 11/12/15:3:08 PM.
 */
public final class LocalTimeAdapter {

    private static final DateTimeFormatter TIME_FORMAT = DateTimeFormatter.ofPattern("HH:mm:ss");

    private LocalTimeAdapter() {

    }

    public static LocalTime unmarshal(String v) {
        if (v == null || v.trim().isEmpty()) {
            return null;
        }
        return LocalTime.parse(v, TIME_FORMAT);
    }

    public static String marshal(LocalTime v) {
        if (v == null) {
            return null;
        }
        return v.format(TIME_FORMAT);
    }
}
