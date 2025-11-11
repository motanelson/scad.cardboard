// CARDBOARD GLASS PARA IMPRESSÃO 3D
// Suporte para lentes VR com sistema Velcro

// ========== CONFIGURAÇÕES PRINCIPAIS ==========
largura_visor = 120;        // Largura total do visor
altura_visor = 60;          // Altura do visor
profundidade_visor = 80;    // Profundidade total

// Lentes
diametro_lente = 40;        // Diâmetro das lentes
distancia_entre_lentes = 65; // Distância entre centros das lentes

// Telemóvel
largura_tele = 75;          // Largura do telemóvel
altura_tele = 150;          // Altura do telemóvel

// ========== MÓDULOS PRINCIPAIS ==========

// Estrutura principal do visor
module estrutura_principal() {
    color("Yellow")
    difference() {
        // Base principal
        cube([largura_visor, profundidade_visor, 5]);
        
        // Abertura para o nariz
        translate([largura_visor/2, profundidade_visor-15, -1])
        scale([0.8, 1, 1])
        cylinder(h=7, r=30, $fn=50);
        translate([30, 25, -0.5]) cylinder(h=30, r=17, center=false, $fn=60);
        translate([60, 25, -0.5]) cylinder(h=30, r=17, center=false, $fn=60);
        translate([90, 25, -0.5]) cylinder(h=30, r=17, center=false, $fn=60);
    }
    
    // Laterais de suporte
    // Lateral esquerda
    color("Yellow")

    translate([0, 0, 0])
    cube([10, profundidade_visor, 30]);
    
    // Lateral direita
    translate([largura_visor-10, 0, 0])
    cube([10, profundidade_visor, 30]);
}

// Suporte para lentes
module suporte_lentes() {
    color("Yellow")

    for(x = [largura_visor/2 - distancia_entre_lentes/2, 
             largura_visor/2 + distancia_entre_lentes/2]) {
        
        translate([x, 25, 5]) {
            // Base da lente
            difference() {
                cylinder(h=8, r=diametro_lente/2 + 5, $fn=60);
                cylinder(h=9, r=diametro_lente/2 + 1, $fn=60);
            }
            
            // Suporte vertical da lente
            translate([0, 0, 8])
            difference() {
                cylinder(h=15, r=diametro_lente/2 + 3, $fn=60);
                cylinder(h=16, r=diametro_lente/2 - 1, $fn=60);
            }
        }
    }
}

// Aba frontal (testa)
module aba_frontal() {
    color("Yellow")

    translate([0, -20, 0])
    difference() {
        cube([largura_visor, 25, 5]);
        
        // Curvatura para conforto
        translate([-1, 20, -1])
        rotate([0, 0, 45])
        cube([40, 40, 7]);
        
        translate([largura_visor-39, 20, -1])
        rotate([0, 0, 45])
        cube([40, 40, 7]);
    }
    
    // Espuma de suporte (representação)
    %translate([largura_visor/2, -10, 5])
    cube([80, 15, 10], center=true);
}

// Aba traseira (fechos Velcro)
module aba_traseira() {
    color("Yellow")

    // Base da aba traseira
    translate([0, profundidade_visor, 0])
    cube([largura_visor, 15, 5]);
    
    // Fechos para Velcro - 4 pontos
    for(x = [20, largura_visor/2, largura_visor-20]) {
        for(z = [10, 13, 16,  20]) {
            translate([x, profundidade_visor + 7, z-20])
            rotate([90, 0, 0])
            cylinder(h=10, r=8, $fn=30);
        }
    }
    // Fechos para Velcro - 4 pontos
    for(x = [20, largura_visor/2, largura_visor-20]) {
        for(z = [10, 13, 16,  20]) {
            translate([x, profundidade_visor + 4, z-18])
            rotate([90, 0, 0])
            cylinder(h=10, r=5, $fn=30);
        }
    }

    


}

// Suporte para telemóvel
module suporte_tele() {
    // Base inferior
    color("Yellow")

    translate([(largura_visor - largura_tele)/2, -5, -15])
    difference() {
        cube([largura_tele, 10, 5]);
        
        // Ranhura para fácil inserção
        translate([5, -1, -1])
        cube([largura_tele-10, 7, 7]);
    }
    
    // Laterais de contenção
    // Lateral esquerda
    translate([(largura_visor - largura_tele)/2 - 5, -5, -15])
    cube([5, 15, 25]);
    
    // Lateral direita
    translate([(largura_visor - largura_tele)/2 + largura_tele, -5, -15])
    cube([5, 15, 25]);
    
    // Suporte traseiro
    translate([(largura_visor - largura_tele)/2, 10, -15])
    cube([largura_tele, 5, 20]);
}

// Abas de proteção ocular
module abas_olhos() {
    color("Yellow")

    // Proteção lateral esquerda
    translate([-15, 20, 13])
    rotate([0, -30, 0])
    cube([20, 40, 3]);
    
    // Proteção lateral direita
    translate([largura_visor-5, 20, 25])
    rotate([0, 30, 0])
    cube([20, 40, 3]);
}

// ========== MONTAGEM FINAL ==========
union() {
    estrutura_principal();
    suporte_lentes();
    aba_frontal();
    aba_traseira();
    suporte_tele();
    abas_olhos();
}

// ========== VISUALIZAÇÃO DO CONJUNTO ==========
// Telemóvel (visualização)
%translate([(largura_visor - largura_tele)/2, 0, -10])
color("Yellow", 0.3)
cube([largura_tele, 5, altura_tele]);


// Alça de cabeça (sugestão)
*translate([largura_visor/2, profundidade_visor + 30, 15])
rotate([90, 0, 0])
color("Yellow", 0.3)
cylinder(h=60, r=2, $fn=20);