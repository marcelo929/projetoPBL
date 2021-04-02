<?php

class Professor
{
    private $nome;
    private $tipoEscola;
    private $auxilio;
    private $experiencia;
    private $qualidade;
    private $plataformas;
    private $camera;
    private $participacao;
    private $frequencia;
    private $opiniao;
    private $bd;

    public function __construct($nome, $tipoEscola, $auxilio, $experiencia, $qualidade,
                                $plataformas, $camera, $participacao, $frequencia, $opiniao) {
        include 'BancoDeDados.Class.php';
        $this->bd = new BancoDeDados();
        $this->nome = $nome;
        $this->tipoEscola = $tipoEscola;
        $this->auxilio = $auxilio;
        $this->experiencia = $experiencia;
        $this->qualidade = $qualidade;
        $this->plataformas = $plataformas;
        $this->camera = $camera;
        $this->participacao = $participacao;
        $this->frequencia = $frequencia;
        $this->opiniao = $opiniao;
    }
    
    public function getColumns(){
        return "(`nome`, `tipoEscola`, `auxilio`, `experiencia`, `qualidade`, `plataformas`, `camera`, `participacao`, `frequencia`, `opiniao`)";
    }

    public function __getClass(){
        return "Professor";
    }

    public function __toString(){
        return "'".$this->nome."', '".$this->tipoEscola."', '".$this->auxilio."', '".
        $this->experiencia."', '".$this->qualidade."', '".$this->plataformas."', '".
        $this->camera."', '".$this->participacao."', '".$this->frequencia."', '".
        $this->opiniao."'";
    }

    public function salvar(){
        $this->bd->insert($this);
    }

}