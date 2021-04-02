<?php

    if ( !(isset($_POST['submitAluno']) || isset($_POST['submitProfessor']))){
        header("location: index.php");
    }
    else{
        if(isset($_POST['submitAluno']))
        {
            include 'Aluno.Class.php';
            $aluno = new Aluno($_POST['nome'], $_POST['tipoEscola'], $_POST['auxilio'],
                     $_POST['frequencia'], $_POST['participacao'],$_POST['qualidade'], 
                     $_POST['experiencia'], $_POST['aprendizado'], $_POST['opiniao']);
            $aluno->salvar();
        }
        else if(isset($_POST['submitProfessor']))
        {
            include 'Professor.Class.php';
            $professor = new Professor($_POST['nome'], $_POST['tipoEscola'], $_POST['auxilio'],
                         $_POST['experiencia'], $_POST['qualidade'], $_POST['plataformas'], 
                         $_POST['camera'], $_POST['participacao'], $_POST['frequencia'], 
                         $_POST['opiniao']);
            $professor->salvar();
        }
        header("location: index.php");
    }

?>