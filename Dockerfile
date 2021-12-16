# image docker du hub sur laquelle se baser
FROM node

WORKDIR /app

## BUILDING

# copie le package.json dans le dossier courrant, comme le WORKDIR est définie, . signifie /app
COPY package.json .

# RUN - execute une commande
RUN npm install

# on copie tout les fichier dans /app
# on copie d'abord le package.json seul pour des raisons d'optimisation (histoires de cache...)
# permet aussi de refaire touts les étapes depuis la step 3 si le package.json change
COPY . ./

# C'est juste de la doc, ca n'expose pas vraiment le port 3000
# le mode exterieur (mon ordi) ne peux pas parler avec un container docker (securitée)
EXPOSE 3000

## RUNNING
CMD ["node", "index.js"]


## BUILD L'IMAGE
# docker build .
# . signifie le dossier courrant mais on pouurrait mettre le path vers ce fichier

# docker image ls
# liste les images

# docker image rm 36274f1a4036
# supprime l'image avec l'id 36274f1a4036

# docker build -t node-app-image .
# build l'image avec un nom

# création du container depuis l'image
# docker run -d --name node-app node-app-image
# docker run [OPTIONS] <imagesToBuild>

# docker ps voir les containers qui tournent
# docker ps

# docker rm node-app -f
# suppr le container node-app de force (sans le stopper avant)

# docker run -p 4000:3000 -d --name node-app node-app-image
# ajout de l'option -p
# 3000 = port surlequel on va envoyer le trafique dans le container (port de l'app)
# 4000 = port surlequel on recoir des requetes du monde exterieur

# docker exec -it node-app bash
# permet de rentrer dans le bash du container qui a la nom node-app en (-it mode interactif)
