# DM Compilation - Mini-C
>* Pour ce projet, nous avons dans un premier temps réalisé le travail de « base » soient un analyseur lexical (nom fichier), un analyseur syntaxique (nom fichier)    et un vérificateur de types (typer.ml). Notre programme affiche également en console les erreurs syntaxiques ainsi que les erreurs de types. (Cf. fichiers tests)

>* Nous avons par la suite décidé de compléter notre projet par des extensions en ajoutant notamment au langage la boucle for ainsi que différents opérateurs comme >, >=, <=, !=, ET (&&) et le OU (||).



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
