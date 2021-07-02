#!/bin/bash
#Criado por Davi Araujo
#
#Script com finalidade de mover arquivos criados a partir de X dias deletando do diretório principal e gerando log do que foi deletado.

#Varíavel vai armazenar a localização do arquivo de log dos arquivos deletados
logg="/var/log/asterisk/ArquivosDel.log"

#Varíavel vai armazenar o diretório dos backups atual
dir="/backup/"

#Variavel vai armazenar o diretório para movimentação dos backups
dirdest="/destino_backup"

dirdest2="/destino_backup2"

#Se caso não for localizado nenhum arquivo que seja mais de X dias ele não irá executar a buscas visto que o valor da busca será igual a 0
if [ -n "$(find $dir -mindepth 1 -mmin +$((60*24)) | head -n 1)" ];  then


#Caso a cópia dos arquivos seja concluida com êxito o mesmo irá deletar os arquivos e listá-los no arquivo de log
   if find $dir -mindepth 1 -mmin +$((60*24)) ! -name '*relatorios*' -exec cp -rf "{}" $dirdest \;; then

     date >> $logg; find $dir -mindepth 1 -mmin +$((60*24)) ! -name '*relatorios*' >> $logg;
     find $dir -mindepth 1 -mmin +$((60*24)) ! -name '*relatorios*' -delete >> /dev/null 2>&1;

     else

     date >> $logg; echo "Erro ao copiar arquivos (configuracao)" >> $logg; echo "" >> $logg;

   fi
   if find $dir -mindepth 1 -mmin +$((60*24)) -name '*relatorios*' -exec cp -rf "{}" $dirdest2 \;; then

     find $dir -mindepth 1 -mmin +$((60*24)) -name '*relatorios*' >> $logg; echo "" >> $logg ;
     find $dir -mindepth 1 -mmin +$((60*24)) -name '*relatorios*' -delete >> /dev/null 2>&1;

     else

     date >> $logg; echo "Erro ao copiar arquivos de relatorios " >> $logg; echo "" >> $logg;

   fi



fi