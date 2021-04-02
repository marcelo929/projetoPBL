<?php

class BancoDeDados{
    
    private $sgbd;
    private $usuario;
    private $senha;
    private $conexao;

    public function __construct(){
        try{
            $this->sgbd = "mysql:host=localhost;dbname=id16311619_projetopbl";
            $this->usuario = "id16311619_admin";
            $this->senha = "bd~0d9[=z9B#RIVR";
            $this->conexao = new PDO($this->sgbd, $this->usuario, $this->senha);
        }
        catch (PDOException $e){
            echo $e;
        }
    }

    public function insert($tabela){
        $query = "insert into ".$tabela->__getClass()." ".$tabela->getColumns()." values (".$tabela->__toString().")";
        $this->conexao->exec($query);
        
    }

     public function select($tabela, $info){
         if($info == null){
            $query = "select * from {$tabela}";
        }
         else{
            $query = "select {$info} from {$tabela}";
        }
        $stmt = $this->conexao->query($query);
        $values = $stmt->fetchAll();
        return $values;
    }

}
?>