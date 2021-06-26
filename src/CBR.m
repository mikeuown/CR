classdef CBR
    %CBR - Classe principal
    %   Guarda as variaveis necessárias para chamar os metodos do ciclo de
    %   vida da técnica CBR
    % retrieve - reuse - revise - retain
    
    properties
        nomeFicheiro = 'cars.xlsx';
        biblioteca_casos;
        novo_caso;
    end
    
    methods (Access = public)
        function this = CBR()
            %CBR contrutor da classe
            %obtem casos da biblioteca de casos do ficheiro com o nome
            %indicado no atributo da classe
            this.biblioteca_casos = this.carregaBibliotecaCasos(this.nomeFicheiro);
        end
        
        %guarda novo caso
        function obtemNovoCaso(~, novo_caso)
            this.novo_caso = novo_caso;
        end
        
        
        function retrieve(~)    
        end
        
        function reuse(~)
        end
        
        function revise(~)
        end
        
        function retain(~)
        end
        
        
    end
    
    methods (Access = private)
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
    end
    
end


