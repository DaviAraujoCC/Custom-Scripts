<?php

#Script criado por Davi para filtrar relatórios csv e inserir os mesmos em uma tabela de acordo com cada coluna


function celular($telefone){
    $telefone= trim(str_replace('/', '', str_replace(' ', '', str_replace('-', '', str_replace(')', '', str_replace('(', '', $telefone))))));

    //$regexTelefone = "^[0-9]{11}$";

    $regexCel = '/[0-9]{2}[6789][0-9]{3,4}[0-9]{4}/'; // Regex para validar somente celular
    if (preg_match($regexCel, $telefone)) {
        return true;
        echo $telefone;
    }else{
        return false;
    }
}

#Mudar o nome do arquivo a ser usado como referência e criar os campos
$row = 1;
if (($handle = fopen("nome_arquivo.csv", "r")) !== FALSE) {
while (($data = fgetcsv($handle, 1000, ";")) !== FALSE) {
        $num = count($data);
        $fone = $data[2];
        $datahora = str_replace("","",(str_replace(":",":",(str_replace("/","-",(str_replace("'","",$data[0])))))));
        $codigo = $data[1];
        $campanha = $data[3];
        $ddd = substr($fone,0,2);
        $row++;
         
        #Definir as propriedades da conexão
        $PDO_actyon = new PDO("dblib:host=localhost;dbname=contoso","user","user1");


    if(celular($fone)){
        $status_tipo_fone = "Celular";
    }else{
        $status_tipo_fone = "Residencial";
    }

        $sql = ("INSERT INTO relatorios (cod_cli,nome,tipo_fone,ddd,fone,foco_id,datetime,ndisc,status,f_leu,data_inclusao,cpf,nome_campanha) VALUES ('$codigo','','$status_tipo_fone','$ddd','$fone','$campanha','$datahora:00','','1','1','$datahora:00','','')");


        sleep(1);

        if($PDO_actyon->query($sql)){
        }else{
        print_r($PDO_actyon->errorInfo());
        }
    }
    fclose($handle);
}



?>