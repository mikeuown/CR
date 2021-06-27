function teste()

    cbr = CBR();

    novo_caso.simbologia = 1;
    novo_caso.perdas = 105;
    novo_caso.fabricante = 'mercedes-benz';
    novo_caso.tipo_combustivel = 'gas';
    novo_caso.aspiracao = 'turbo';
    novo_caso.num_portas = 'four';
    novo_caso.tipo_carrocaria = 'wagon';
    novo_caso.tracao = '4wd';
    novo_caso.localizacao_motor = 'front';
    novo_caso.base_rodas = 90;
    novo_caso.comprimento = 150;
    novo_caso.largura = 65.7;
    novo_caso.altura = 50.9;
    novo_caso.peso_curb = 105;
    novo_caso.tipo_motor = 'ohcf';
    novo_caso.num_cilindros = 'four';
    novo_caso.tam_motor = 105;
    novo_caso.sistema_combustivel = 'mfi';
    novo_caso.calibre = 3.2 ;
    novo_caso.stroke = 3.4;
    novo_caso.racio_compressao = 8;
    novo_caso.cavalos = 200;
    novo_caso.max_rpm = 6000;
    novo_caso.cidade_mpg = 30;
    novo_caso.autoestrada_mpg = 43;
    
    cbr.retrieve(novo_caso);
    



end