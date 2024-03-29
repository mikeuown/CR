classdef CBR
    %CBR - Classe principal
    %   Guarda as variaveis necessárias para chamar os metodos do ciclo de
    %   vida da técnica CBR
    % retrieve - reuse - revise - retain
    
    properties (Access = private)
        nomeFicheiro = 'cars.xlsx';
        threshold;
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
            
            this.threshold = 0.9;
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
        function [indices] = retrieve(~, caso_novo)
            disp('fase retrive');      
            
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
        
        
        %=============== Tabela de semelhancas ===================
        
        %obtem tabela de semelhanças de fabricantes 
        function fabricante_sim = get_fabricante_sim(~)
            
            fabricante_sim.categorias = categorical({'alfa-romero', 'audi', 'bmw', 'chevrolet', 'dodge', 'honda', 'isuzu', 'jaguar', 'mazda', 'mercedes-benz', 'mercury', 'mitsubishi', 'nissan', 'peugot', 'plymouth', 'porsche', 'renault', 'saab', 'subaru', 'toyota', 'volkswagen', 'volvo'});
            
            fabricante_sim.tabela_semelhancas = [
                %   alfa-romero  audi  bmw   chevrolet  dodge   honda    isuzu   jaguar   mazda    mercedes-benz   mercury    mitsubishi  nissan    peugot  plymouth  porsche   renault    saab    subaru  toyota    volkswagen  volvo
                        1.0           % alfa-romero  
                        x         % audi
                                   % bmw
                                   % chevrolet
                                   % dodge
                                   % honda
                                   % isuzu
                                   % jaguar
                                   % mazda
                                   % mercedes-benz
                                   % mercury
                                   % mitsubishi
                                   % nissan
                                   % peugot
                                   % plymouth
                                   % porsche
                                   % renault
                                   % saab
                                   % subaru  
                                   % toyota    
                                   % volkswagen  
                                   % volvo
                ];
        end
        
        %obtem tabela de semelhanças do tipo de carrocari
        function tipo_carrocaria_sim = get_tipo_carrocaria_sim(~)
            
            tipo_carrocaria_sim.categorias = categorical({'hardtop', 'wagon', 'sedan', 'hatchback', 'convertible'});
            
            tipo_carrocaria_sim.tabela_semelhancas = [
                %   hardtop  wagon  sedan   hatchback  convertible
                        1.0           % hardtop 
                        x         % wagon
                                   % sedan
                                   % hatchback
                                   % convertible
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
                %   1bbl  2bbl  4bbl   idi  mfi  mpfi  spdi  spfi
                1.0           % 1bbl
                x         % 2bbl
                % 4bbl
                % idi
                % mfi
                % mpfi
                % spdi
                % spfi
                ];
        end
        
        
        %======== Calcular semelhanca entre dois valores/atributos ========
        
        %calcula a distancia local entre dois atributos com base na tabela
        %de semelhancas
        function res = calcula_distancia_local(~,sim, val1, val2)
            i1 = find(sim.categorias == val1);
            i2 = find(sim.categorias == val2);
            res = 1 - sim.tabela_semelhancas(i1,i2);
        end
        
        %calcula distancia euclidiana entre dois inteiros
        function res = calcula_distancia_euclidiana(~, val1, val2)
            dif = val1 - val2;
            res = sqrt(dif * dif);
        end
        
    end
    
end


