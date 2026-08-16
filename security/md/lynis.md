# Linys ([retour](../SECURITY.md))

Linys est un outil permettant de réaliser des audits de sécurité, principalement conçu pour les serveurs, mais qui peut être utilisé sur n'importe quelle machine.

Le principe est qu'il réalise un ensemble de tests sur le système et forme un rapport avec les « Warnings » (vulnérabilités importantes qu'il faut absolument résoudre) et les « Suggestions » (ensemble d'éléments que l'on peut mettre en place pour renforcer son système), avec, pour chacun, des liens vers des articles pour expliquer le principe du test et comment le résoudre. 

Nous avons aussi un score en pourcentage nommé le « Hardening Index », permettant d'avoir une idée du niveau de sécurité de son système (l'objectif étant d'avoir au moins 80 à 85 %).

### Installation :

```
sudo pacman -S lynis fakeroot net-tools bind-tools
```

### Utilisation :

Pour lancer un audit du système :
```
sudo lynis audit system
```

Pour obtenir les logs d'un test spécifique :
```
sudo lynis show details [identifiant du test, par exemple : KRNL-6000]
```

L'objectif de ce README est de répertorier les suggestions/warnings que j'ai eus et leurs solutions.

## Sommaire :
1. [KRNL-5820.](./Lynis/KRNL-5820.md)
2. [AUTH-9230.](./Lynis/AUTH-9230.md)
3. [AUTH-9282 et AUTH-9328.](./Lynis/AUTH-9282-9328.md)
4. [STRG-1846.](./Lynis/STRG-1846.md)
5. [FINT-4350.](./Lynis/FINT-4350.md)
6. [ACCT-9622.](./Lynis/ACCT-9622.md)
7. [HTTP-6640.](./Lynis/HTTP-6640.md)
8. [HTTP-6643.](./Lynis/HTTP-6643.md)
9. [PKGS-7398.](./Lynis/PKGS-7398.md)
10. [NETW-3200.](./Lynis/NETW-3200.md)
11. [PHP-2372 et PHP-2376.](./Lynis/PHP-2372-2376.md)
12. [ACCT-9626.](./Lynis/ACCT-9626.md)
13. [TIME-3104.](./Lynis/TIME-3104.md)
14. [MALW-3286.](./Lynis/MALW-3286.md)
15. [HRDN-7222.](./Lynis/HRDN-7222.md)
16. [NAME-4028 et NAME-4404.](./Lynis/NAME-4028-4404.md)
17. [BANN-7126.](./Lynis/BANN-7126.md)
18. [ACCT-9630.](./Lynis/ACCT-9630.md)
19. [FILE-7524.](./Lynis/FILE-7524.md)
20. [KRNL-6000.](./Lynis/KRNL-6000.md)
21. [TIME-3185.](./Lynis/TIME-3185.md)