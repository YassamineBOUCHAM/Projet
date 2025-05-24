# description 

food and Go une application mobile développée avec flutter qui permet aux utilisateurs d'explorer une variété de plats répartis en différentes catégories:
Burger,Désert,et Entrebl'application propose:
# fonctionalité
.page de login & inscription
.Menu
.Exploration des plats par catégorie(Entrée,Dessert,Burger)
.Détails de chaque plat(image,decription,ingrédients)
.page Téléchargement(pdf/image)
.Accés a un calendeier(planification des repas)
# Captures d'écran


![téléchargement (1)](https://github.com/user-attachments/assets/d4bd102b-7328-48df-a9c1-0ba101c906ee)
# les page de figma 
![Capture d'écran 2025-05-24 153035](https://github.com/user-attachments/assets/e8e44c9f-e098-47b3-99ea-838a99ecbbfa)
![Capture d'écran 2025-05-23 225552](https://github.com/user-attachments/assets/88aab058-453a-4194-bb0c-442093ff8940)
![Capture d'écran 2025-05-23 225725](https://github.com/user-attachments/assets/4c6dabde-8c31-4327-9364-e8d608c817b6)
![Capture d'écran 2025-05-23 230148](https://github.com/user-attachments/assets/a68336f5-67fc-41fe-9697-1c88536b50c2)
# navigation 
Lors de la première visite sur le site, l’utilisateur arrive sur une page de login. S’il n’a pas encore de compte, il clique sur "Sign Up", remplit un formulaire avec son nom d’utilisateur et son mot de passe, puis son compte est créé et il est automatiquement redirigé vers la page d’accueil. S’il a déjà un compte, il peut se connecter directement en cliquant sur "Sign In" et en saisissant ses identifiants. Une fois connecté, l’utilisateur accède à la page d’accueil qui contient un calendrier affichant les dates et les menus planifiés pour chaque jour. Pour chaque date, il peut consulter les entrées, les plats principaux et les desserts prévus, accompagnés des ingrédients et d’une notation en étoiles. L’utilisateur peut également modifier les menus, ajouter de nouvelles dates avec des recettes personnalisées, et a la possibilité de télécharger les menus affichés au format PDF ou image.
# Explicatin de chaque page
.page avec Login / Sign Up / Sign In :
Lorsqu'un utilisateur visite un site pour la première fois, il arrive sur une page de login.
S'il n'a pas encore de compte, il peut cliquer sur le bouton "Sign Up" pour s'inscrire.


t un formulaire avec des informations comme le nom d'utilisateur et le mot de passe.

Une fois les informations validées, le compte est créé.

L'utilisateur est automatiquement connecté et redirigé vers la page d'accueil du site.

S'il a déjà un compte, il peut cliquer sur le bouton "Sign In":

Le site lui demande simplement son email et son mot de passe.

S'ils sont corrects, il est connecté à son compte
.téléchargement (Download)
Après avoir consulté un menu dans le calendrier, l’utilisateur peut accéder à une page dédiée au téléchargement des menus. Cette page propose deux boutons principaux :

"PDF"

"Image"

L’utilisateur choisit le format dans lequel il souhaite obtenir le menu.

S’il clique sur "Image" : une nouvelle page s’ouvre, affichant deux options :

"Voir" : pour afficher le menu sous forme d’image à l’écran.

"Télécharger" : pour enregistrer l’image du menu dans son appareil (ex. : téléphone, ordinateur).

S’il clique sur "PDF" : même fonctionnement :

"Voir" : pour ouvrir un aperçu du menu au format PDF.

"Télécharger" : pour enregistrer le document PDF
. la page "Calendrier"
La page Calendrier permet à l’utilisateur de visualiser et gérer les menus quotidiens. Elle affiche un calendrier avec les dates, et pour chaque date sélectionnée, on voit les menus prévus :

Entrée

Plat principal

Dessert

Chaque menu contient des informations comme le nom du plat, les ingrédients, et éventuellement une note (étoiles).

L’utilisateur peut interagir avec les menus associés à chaque date. Il a plusieurs options :

Ajouter un nouveau menu (entrée, plat ou dessert) pour une date spécifique.

Modifier un menu existant (changer le nom, les ingrédients, etc.).

Supprimer un menu si celui-ci ne doit plus être préparé.

Cette page permet donc une planification souple et personnalisée des repas sur plusieurs jours, tout en offrant un aperçu clair de ce qui est prévu à tout moment.
# Captuer de jira 


# command pour instaler
flutter pub get
flutter run 








