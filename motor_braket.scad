motor_capi = 63;
duvar_kalinligi = 5;
braket_yuksekligi = 40;
vida_deligi_capi = 6.5;
tolerans = 0.01;

assert(motor_capi > 0, "Hata: Motor çapı sıfırdan büyük olmalıdır!");
assert(duvar_kalinligi >= 2, "Uyarı: Güvenli üretim için et kalınlığı yetersiz!");

$fn = 64;

ana_montaj();

module ana_montaj() {
    difference() {
        temel_form(motor_capi + (duvar_kalinligi * 2));

        translate([0, 0, -tolerans])
            temel_form(motor_capi);

        vida_deliklerini_ac();
    }
}

module temel_form(cap) {
    linear_extrude(height = braket_yuksekligi) {
        circle(d = cap);
    }
}

module vida_deliklerini_ac() {
    for (aci = [0, 90, 180, 270]) {
        rotate([0, 0, aci])
            translate([(motor_capi/2) + (duvar_kalinligi/2), 0, -tolerans])
                cylinder(h = braket_yuksekligi + (tolerans * 2), d = vida_deligi_capi);
    }
}