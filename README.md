# DM Compilation - Mini-C
>* Pour ce projet, nous avons dans un premier temps réalisé le travail de « base » soit un analyseur lexical (implexer.mll), un analyseur syntaxique (impparser.mly)    et un vérificateur de types (typer.ml). Notre programme affiche également en console les erreurs syntaxiques ainsi que les erreurs de types. (Cf. fichiers tests)
>* Nous avons par la suite décidé de compléter notre projet par des extensions en ajoutant notamment au langage la boucle for qui n'est pas totalement terminée mais presque (il ne manque presque rien mais nous n'avons pas pu finir par manque de temps), ainsi que différents opérateurs comme >, >=, <=, !=, ET (&&) et le OU (||).	

# Instructions d'utilisation dans la console

## À taper une seule fois pour créer un environnement :
```
eval $(opam config env)
```

## Puis à chaque modification, compiler avec :
```
ocamlbuild main.native
```
## Et tester avec :
```
./main.native [nom du fichier c à tester].c

exemple: 
./main.native test.c	
```	
