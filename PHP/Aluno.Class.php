<?php

class Aluno
{
    private $nome;
    private $tipoEscola;
    private $auxilio;
    private $frequencia;
    private $participacao;
    private $qualidade;
    private $experiencia;
    private $aprendizado;
    private $opiniao;
    private $bd;

    public function __construct($nome, $tipoEscola, $auxilio, $frequencia, $participacao,
                                $qualidade, $experiencia, $aprendizado, $opiniao){
        include 'BancoDeDados.Class.php';
        $this->bd = new BancoDeDados();
        $this->nome = $nome;
        $this->tipoEscola = $tipoEscola;
        $this->auxilio = $auxilio;
        $this->frequencia = $frequencia;
        $this->participacao = $participacao;
        $this->qualidade = $qualidade;
        $this->experiencia = $experiencia;
        $this->aprendizado = $aprendizado;
        $this->opiniao = $opiniao;
    }        
    
    public function getColumns(){
        return "(`nome`, `tipoEscola`, `auxilio`, `frequencia`, `participacao`, `qualidade`, `experiencia`, `aprendizado`, `opiniao`)";
    }

    public function __getClass(){
        return "Aluno";
    }

    public function __toString(){
        return "'".$this->nome."', '".$this->tipoEscola."', '".$this->auxilio."', '".
        $this->frequencia."', '".$this->participacao."', '".$this->qualidade."', '".
        $this->experiencia."', '".$this->aprendizado."', '".$this->opiniao."'";
    }

    public function salvar(){
        $this->bd->insert($this);
    }
}
?>