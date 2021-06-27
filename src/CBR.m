classdef CBR
    %CBR - Classe principal
    %   Guarda as variaveis necessárias para chamar os metodos do ciclo de
    %   vida da técnica CBR
    % retrieve - reuse - revise - retain
    
    properties (Access = private)
        peso_atributos = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
        nomeFicheiro = 'cars.xlsx';
        threshold = 0.9;
        biblioteca_casos;
        novo_caso;
    end
    
    %Construtor, Getters e Setters
    methods
        
        %Construtor
        function this = CBR()
            %CBR contrutor da classe
            %obtem casos da biblioteca de casos do ficheiro com o nome
            %indicado no atributo da classe
            
            this.biblioteca_casos = this.carregaBibliotecaCasos(this.nomeFicheiro);
            
          
        end
        
        %obtem biblioteca de casos
        function value = get.biblioteca_casos(this)
            value = this.biblioteca_casos;
        end
        
        %guarda novo caso
        function this = set.novo_caso(this, novo_caso)
            this.novo_caso = novo_caso;
        end
    end
    
    %metodos que representam cada fase do ciclo de vida CBR
    methods (Access = public)
       
        %{
        Função Retrieve

        Obtem casos semelhantes da BD com base na função de semelhança
        Develve os indices da tabela que tenham uma similiaridade superior ao
        indicado na variavel threshold
        %}
        function [indices, semelhancas] = retrieve(this, caso_novo)
            disp('fase retrive');
            
            
            %obtem tabelas de semelhanca dos atributos nominais
            fabricante_sim = this.get_fabricante_sim();
            
            tipo_carrocaria_sim = this.get_tipo_carrocaria_sim();
            
            tracao_sim = this.get_tracao_sim();
            
            %tipo_motor_sim = this.get_tipo_motor_sim();
            
            num_cilindros_sim = this.get_num_cilindros_sim();
            
            sistema_combustivel_sim = this.get_sistema_combustivel_sim();
            
            
            %obtem valores maximos dos atributos numericos
            valores_maximos = get_valores_maximos(this);
            
            %obtem valores minimos dos atributo numericos
            valores_minimos = get_valores_minimos(this);
            
            %indices dos casos que tenham uma semelhanca igual ou superior
            %ao threshold
            indices = [];
            
            %grau de semelhanca dos casos 
            semelhancas = [];
            
            
            for i=1:size(this.biblioteca_casos,1)
                
                distancias= zeros(1,size(this.biblioteca_casos, 2));
                
                nome_atributo = 'symboling';
                distancias(1,1) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.simbologia) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'normalized-losses';
                distancias(1,2) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.perdas) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'make';
                distancias(1,3) = calcula_distancia_local(this, fabricante_sim, ...
                this.biblioteca_casos{i, nome_atributo}, caso_novo.fabricante);
                                
                nome_atributo = 'fuel-type';
                distancias(1,4) = calcula_distancia_bool(this, ...
                    this.biblioteca_casos{i,nome_atributo}, caso_novo.tipo_combustivel);
                     
                nome_atributo = 'aspiration';
                distancias(1,5) = calcula_distancia_bool(this, ...
                        this.biblioteca_casos{i,nome_atributo}, caso_novo.aspiracao);          
                     
                nome_atributo = 'num-of-doors';
                distancias(1,6) = calcula_distancia_bool(this,...
                    this.biblioteca_casos{i,nome_atributo}, caso_novo.num_portas);
                           
                nome_atributo = 'body-style';
                distancias(1,7) = calcula_distancia_local(this, tipo_carrocaria_sim,...
                    this.biblioteca_casos{i, nome_atributo}, caso_novo.tipo_carrocaria);
                
                nome_atributo = 'drive-wheels';
                distancias(1,8) = calcula_distancia_local(this, tracao_sim,...
                    this.biblioteca_casos{i, nome_atributo}, caso_novo.tracao);
                
                nome_atributo = 'engine-location';
                distancias(1,9) = calcula_distancia_bool(this, ...
                    this.biblioteca_casos{i,nome_atributo}, caso_novo.localizacao_motor);               
                
                nome_atributo = 'wheel-base';
                distancias(1,10) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.base_rodas) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'length';
                distancias(1,11) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.comprimento) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'width';
                distancias(1,12) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.largura) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'height';
                 distancias(1,13) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.altura) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'curb-weight';
                distancias(1,14) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.peso_curb) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
%                 nome_atributo = 'engine-type';
%                 distancias(1,15) = calcula_distancia_local(this, tipo_motor_sim ,...
%                     this.biblioteca_casos{i, nome_atributo}, caso_novo.tipo_motor);
%                 
                nome_atributo = 'num-of-cylinders';
                distancias(1,16) = calcula_distancia_local(this,num_cilindros_sim,...
                    this.biblioteca_casos{i, nome_atributo}, caso_novo.num_cilindros);
                
                nome_atributo = 'engine-size';
                distancias(1,17) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.tam_motor) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'fuel-system';
                distancias(1,18) = calcula_distancia_local(this,sistema_combustivel_sim,...
                    this.biblioteca_casos{i, nome_atributo}, caso_novo.sistema_combustivel);
                
                nome_atributo = 'bore';
                  distancias(1,19) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.calibre) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'stroke';
                 distancias(1,20) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.stroke) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'compression-ratio';
                distancias(1,21) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.racio_compressao) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'horsepower';
                distancias(1,22) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.cavalos) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'peak-rpm';
                distancias(1,23) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.max_rpm) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'city-mpg';
                distancias(1,24) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.cidade_mpg) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                nome_atributo = 'highway-mpg';
                 distancias(1,24) = calcula_distancia_euclidiana(this,...
                    (this.biblioteca_casos{1,nome_atributo} - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo)),...
                    (caso_novo.autoestrada_mpg) - valores_minimos(nome_atributo))/...
                    (valores_maximos(nome_atributo) - valores_minimos(nome_atributo));
                
                
                %((distances * weighting_factors')/sum(weighting_factors));
                semelhanca_final = 1 - ((distancias * this.peso_atributos')/sum(this.peso_atributos));
                
                
                if semelhanca_final >= this.threshold
                    
                    indices = [indices i];
                    semelhancas = [semelhancas semelhanca_final];
                    
                end
                
                    fprintf('Caso %d de %d tem um semelhanca de ', i, size(this.biblioteca_casos,1));
                    fprintf('%.2f%%\n',  semelhanca_final*100);
                    %fprintf('Case %d out of %d has a similarity of %.2f%%...\n', i, size(this.biblioteca_casos,1), semelhanca_final*100);
            end
            
        end
        
        function reuse(~)
        end
        
        function revise(~)
        end
        
        function retain(~)
        end
        
        
    end
    
    %metodos auxiliares
    methods (Access = private)
        
        %==================== Funçoes auxiliares ==========================
        
        %carrega biblioteca de casos
        function biblioteca_casos = carregaBibliotecaCasos(~, nomeFicheiro)
            %Obtem a libraria de casos do ficheiro indicado em forma de tabela
            
            %obtem opções da tabela do ficheiro excel
            opt = detectImportOptions(nomeFicheiro);
            
            %altera o tipo dos atributos com o indice indicado para double, os
            %restantes mantêm-se como sendo do tipo string
            opt = setvartype(opt,[1 2 10 11 12 13 14 17 19 20 21 22 23 24 25 26],...
                'double');
            
            
            %obtem tabela com biblioteca de casos o ficheiro
            biblioteca_casos = readtable(nomeFicheiro, opt);
            
            %Altera o nome dos atributos
            biblioteca_casos.Properties.VariableNames{'Var1'} = 'symboling';
            biblioteca_casos.Properties.VariableNames{'Var2'} = 'normalized-losses';
            biblioteca_casos.Properties.VariableNames{'Var3'} = 'make';
            biblioteca_casos.Properties.VariableNames{'Var4'} = 'fuel-type';
            biblioteca_casos.Properties.VariableNames{'Var5'} = 'aspiration';
            biblioteca_casos.Properties.VariableNames{'Var6'} = 'num-of-doors';
            biblioteca_casos.Properties.VariableNames{'Var7'} = 'body-style';
            biblioteca_casos.Properties.VariableNames{'Var8'} = 'drive-wheels';
            biblioteca_casos.Properties.VariableNames{'Var9'} = 'engine-location';
            biblioteca_casos.Properties.VariableNames{'Var10'} = 'wheel-base';
            biblioteca_casos.Properties.VariableNames{'Var11'} = 'length';
            biblioteca_casos.Properties.VariableNames{'Var12'} = 'width';
            biblioteca_casos.Properties.VariableNames{'Var13'} = 'height';
            biblioteca_casos.Properties.VariableNames{'Var14'} = 'curb-weight';
            biblioteca_casos.Properties.VariableNames{'Var15'} = 'engine-type';
            biblioteca_casos.Properties.VariableNames{'Var16'} = 'num-of-cylinders';
            biblioteca_casos.Properties.VariableNames{'Var17'} = 'engine-size';
            biblioteca_casos.Properties.VariableNames{'Var18'} = 'fuel-system';
            biblioteca_casos.Properties.VariableNames{'Var19'} = 'bore';
            biblioteca_casos.Properties.VariableNames{'Var20'} = 'stroke';
            biblioteca_casos.Properties.VariableNames{'Var21'} = 'compression-ratio';
            biblioteca_casos.Properties.VariableNames{'Var22'} = 'horsepower';
            biblioteca_casos.Properties.VariableNames{'Var23'} = 'peak-rpm';
            biblioteca_casos.Properties.VariableNames{'Var24'} = 'city-mpg';
            biblioteca_casos.Properties.VariableNames{'Var25'} = 'highway-mpg';
            biblioteca_casos.Properties.VariableNames{'Var26'} = 'price';
            
            disp('biblioteca carregada');
        end
        
        %obtem tabela com valores maximos de cada atributo numerico
        function [max_values] = get_valores_maximos(~)
            
            key_set = {'symboling', 'normalized-losses', 'wheel-base', 'length',...
                'width', 'height', 'curb-weight', 'engine-size','bore', 'stroke',...
                'compression-ratio', 'horsepower', 'peak-rpm', 'city-mpg', 'highway-mpg'};
            
            value_set = {3, 256, 120.9, 208.1, 72.3, 59.8, 4066, 326, 3.94,...
                4.17, 23, 288, 6600, 49, 54
                };
            
            max_values = containers.Map(key_set, value_set);
        end
        
        %obtem tabela com valores minimos de cada atributo numerico
        function [min_values] = get_valores_minimos(~)
            
            key_set = {'symboling', 'normalized-losses', 'wheel-base', 'length',...
                'width', 'height', 'curb-weight', 'engine-size','bore', 'stroke',...
                'compression-ratio', 'horsepower', 'peak-rpm', 'city-mpg', 'highway-mpg'};
            
            value_set = {-3, 65, 86.6, 141.1, 60.3, 47.8, 1488, 61, 2.54,...
                2.07, 7, 48, 4150, 13, 16
                };
            
            min_values = containers.Map(key_set, value_set);
        end
        
        %=============== Tabela de semelhancas ===================
        
        %obtem tabela de semelhanças de fabricantes 
        function fabricante_sim = get_fabricante_sim(~)
            
            fabricante_sim.categorias = categorical({'alfa-romero', 'audi', 'bmw', 'chevrolet', 'dodge', 'honda', 'isuzu', 'jaguar', 'mazda', 'mercedes-benz', 'mercury', 'mitsubishi', 'nissan', 'peugot', 'plymouth', 'porsche', 'renault', 'saab', 'subaru', 'toyota', 'volkswagen', 'volvo'});
            
            fabricante_sim.tabela_semelhancas = [
                %   alfa-romero  audi   bmw   chevrolet  dodge   honda    isuzu   jaguar   mazda    mercedes-benz   mercury    mitsubishi  nissan    peugot  plymouth  porsche   renault    saab    subaru  toyota    volkswagen  volvo
                        1.0      0.859  0.953  0.812     0.671   0.342    0.624   0.906    0.577       0.953        0.436        0.248     0.530     0.342   0.765     0.859     0.295      0.154   0.483   0.718     0.201       0.906  % alfa-romero
                        0.859    1.0    0.812  0.953     0.812   0.483    0.765   0.765    0.718       0.906        0.483        0.389     0.671     0.530   0.906     0.718     0.436      0.295   0.624   0.859     0.342       0.953  % audi
                        0.953    0.812  1.0    0.765     0.624   0.295    0.624   0.953    0.530       0.906        0.389        0.201     0.483     0.342   0.718     0.906     0.248      0.107   0.436   0.671     0.154       0.859  % bmw
                        0.812    0.953  0.765  1.0       0.859   0.530    0.812   0.718    0.295       0.859        0.624        0.436     0.718     0.577   0.953     0.671     0.483      0.342   0.671   0.906     0.389       0.906  % chevrolet
                        0.671    0.812  0.624  0.859     1.0     0.671    0.953   0.577    0.906       0.718        0.765        0.577     0.859     0.718   0.906     0.530     0.624      0.483   0.812   0.953     0.530       0.765  % dodge
                        0.342    0.483  0.295  0.530     0.671   1.0      0.718   0.248    0.765       0.389        0.906        0.906     0.812     0.953   0.577     0.201     0.953      0.812   0.859   0.624     0.859       0.436  % honda
                        0.624    0.765  0.624  0.812     0.953   0.718    1.0     0.530    0.953       0.671        0.812        0.624     0.906     0.765   0.859     0.483     0.671      0.530   0.859   0.906     0.577       0.718  % isuzu
                        0.906    0.765  0.953  0.718     0.577   0.248    0.530   1.0      0.483       0.859        0.342        0.153     0.436     0.295   0.671     0.953     0.201      0.060   0.389   0.577     0.107       0.812  % jaguar
                        0.577    0.718  0.530  0.295     0.906   0.765    0.953   0.483    1.0         0.624        0.859        0.671     0.953     0.812   0.812     0.436     0.718      0.577   0.906   0.859     0.624       0.671  % mazda
                        0.953    0.906  0.906  0.859     0.718   0.389    0.671   0.859    0.624       1.0          0.483        0.295     0.577     0.436   0.812     0.812     0.342      0.201   0.530   0.765     0.248       0.953  % mercedes-benz
                        0.436    0.483  0.389  0.624     0.765   0.906    0.812   0.342    0.859       0.483        1.0          0.812     0.905     0.953   0.671     0.295     0.859      0.718   0.953   0.718     0.765       0.530  % mercury
                        0.248    0.389  0.201  0.436     0.577   0.906    0.624   0.153    0.671       0.295        0.812        1.0       0.718     0.859   0.483     0.107     0.953      0.906   0.765   0.530     0.953       0.342  % mitsubishi
                        0.530    0.671  0.483  0.718     0.859   0.812    0.906   0.436    0.953       0.577        0.905        0.718     1.0       0.859   0.765     0.389     0.765      0.624   0.953   0.812     0.718       0.624  % nissan
                        0.342    0.530  0.342  0.577     0.718   0.953    0.765   0.295    0.812       0.436        0.953        0.859     0.859     1.0     0.624     0.248     0.906      0.765   0.906   0.671     0.812       0.483  % peugot
                        0.765    0.906  0.718  0.953     0.906   0.577    0.859   0.671    0.812       0.812        0.671        0.483     0.765     0.624   1.0       0.624     0.530      0.389   0.718   0.953     0.436       0.859  % plymouth
                        0.859    0.718  0.906  0.671     0.530   0.201    0.483   0.953    0.436       0.812        0.295        0.107     0.389     0.248   0.624     1.0       0.154      0.013   0.342   0.577     0.060       0.765  % porsche
                        0.295    0.436  0.248  0.483     0.624   0.953    0.671   0.201    0.718       0.342        0.859        0.953     0.765     0.906   0.530     0.154     1.0        0.859   0.812   0.577     0.906       0.389  % renault
                        0.154    0.295  0.107  0.342     0.483   0.812    0.530   0.060    0.577       0.201        0.718        0.906     0.624     0.765   0.389     0.013     0.859      1.0     0.671   0.436     0.953       0.248  % saab
                        0.483    0.624  0.436  0.671     0.812   0.859    0.859   0.389    0.906       0.530        0.953        0.765     0.953     0.906   0.718     0.342     0.812      0.671   1.0     0.765     0.718       0.577  % subaru
                        0.718    0.859  0.671  0.906     0.953   0.906    0.906   0.577    0.859       0.765        0.718        0.530     0.812     0.671   0.953     0.577     0.577      0.906   0.765   1.0       0.483       0.812  % toyota
                        0.201    0.342  0.906  0.389     0.530   0.577    0.577   0.107    0.624       0.248        0.765        0.953     0.718     0.812   0.436     0.060     0.906      0.953   0.718   0.483     1.0         0.295  % volkswagen
                        0.906    0.953  0.389  0.906     0.765   0.718    0.718   0.812    0.671       0.953        0.530        0.342     0.624     0.483   0.859     0.765     0.389      0.248   0.577   0.812     0.295       1.0    % volvo
                    ];
        end
        
        %obtem tabela de semelhanças do tipo de carrocari
        function tipo_carrocaria_sim = get_tipo_carrocaria_sim(~)
            
            tipo_carrocaria_sim.categorias = categorical({'hardtop', 'wagon', 'sedan', 'hatchback', 'convertible'});
            
            tipo_carrocaria_sim.tabela_semelhancas = [
                %   hardtop  wagon  sedan   hatchback  convertible
                    1.0      0.6    0.4     0.8        0.8         % hardtop
                    0.6      1.0    0.8     0.8        0.4         % wagon
                    0.4      0.8    1.0     0.6        0.2         % sedan
                    0.8      0.8    0.6     1.0        0.6         % hatchback
                    0.8      0.4    0.2     0.6        1.0         % convertible
                ];
        end
        
        %obtem tabela de semelhanças do tipo de tracao
        function tracao_sim = get_tracao_sim(~)
            
            tracao_sim.categorias = categorical({'4wd', 'fwd', 'rwd'});
            
            tracao_sim.tabela_semelhancas = [
                %   4wd  fwd  rwd 
                    1.0  0.5  0.5 % 4wd
                    0.5  1.0  0.3 % fwd
                    0.5  0.3  1.0 % rwd              
                ];
        end
          
        %obtem tabela de semelhanças dos tipos de motores
        function tipo_motor_sim = get_tipo_motor_sim(~)
            
            tipo_motor_sim.categorias = categorical({'dohc', 'dohcv', 'l', 'ohc', 'ohcf', 'ohcv', 'rotor'});
            
            tipo_motor_sim.tabela_semelhancas = [
                %   dohc  dohcv  l   ohc  ohcf  ohcv    rotor
                1.0           % dohc
                x         % dohcv
                % l
                % ohc
                % ohcf
                % ohcv
                % rotor
                ];
        end
        
         %obtem tabela de semelhanças do numero de cilindros
        function num_cilindros_sim = get_num_cilindros_sim(~)
            
            num_cilindros_sim.categorias = categorical({'eight', 'five', 'four', 'six', 'three', 'twelve', 'two'});
            
            num_cilindros_sim.tabela_semelhancas = [
                %   eight  five  four   six  three  twelve   two
                     1.0   0.75  0.67   0.84  0.58   0.80    0.5  % eight
                     0.75  1.0   0.92   0.92  0.84   0.42    0.75 % five
                     0.67  0.92  1.0    0.84  0.92   0.34    0.84 % four
                     0.84  0.92  0.84   1.0   0.74   0.5     0.67 % six
                     0.58  0.84  0.92   0.74  1.0    0.25    0.92 % three
                     0.80  0.42  0.34   0.5   0.25   1.0     0.17% twelve
                     0.5   0.75  0.84   0.67  0.92   0.17    1.0% two
                ];
        end
        
          
         %obtem tabela de semelhanças do sistema de combustivel
        function sistema_combustivel_sim = get_sistema_combustivel_sim(~)
            
            sistema_combustivel_sim.categorias = categorical({'1bbl', '2bbl', '4bbl', 'idi', 'mfi', 'mpfi', 'spdi', 'spfi'});
            
            sistema_combustivel_sim.tabela_semelhancas = [
                %   1bbl    2bbl   4bbl   idi    mfi    mpfi   spdi   spfi
                    1.0     0.875  0.750  0.625  0.500  0.375  0.250  0.125  % 1bbl
                    0.875   1.0    0.875  0.750  0.625  0.500  0.375  0.250  % 2bbl
                    0.750   0.875  1.0    0.875  0.750  0.625  0.500  0.375  % 4bbl
                    0.625   0.750  0.875  1.0    0.875  0.750  0.625  0.500  % idi
                    0.500   0.625  0.750  0.875  1.0    0.875  0.750  0.625  % mfi
                    0.375   0.500  0.625  0.750  0.875  1.0    0.875  0.750  % mpfi
                    0.250   0.375  0.500  0.625 0.750   0.875  1.0    0.875  % spdi
                    0.125   0.250  0.375  0.500 0.625   0.760  0.876  1.0    % spfi
                ];
        end
        
        
        %======== Calcular semelhanca entre dois valores/atributos ========
        
        %calcula a distancia local entre dois atributos com base na tabela
        %de semelhancas
        function res = calcula_distancia_local(~,sim, val1, val2)
            
            i1 = find(sim.categorias == val1);
            i2 = find(sim.categorias == val2);
            
          
            %disp(val2)
            res = 1 - sim.tabela_semelhancas(i1,i2);
        end
        
        %calcula distancia euclidiana entre dois inteiros
        function res = calcula_distancia_euclidiana(~, val1, val2)
            dif = val1 - val2;
            res = sqrt(dif * dif);
        end
        
        %calcula distancia booleana
        function res = calcula_distancia_bool(~, val1, val2)
            
            if strcmp(val1, val2) == 1
                res = 0;
            else
               res = 1; 
            end
        end
    end
    
end


