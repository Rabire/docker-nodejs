# image docker du hub sur laquelle se baser
FROM node

WORKDIR /app

## BUILDING

COPY package.json .
# copie le package.json dans le dossier courrant, comme le WORKDIR est définie, . signifie /app

RUN npm install
# RUN - execute une commande

COPY . ./
# on copie tout les fichier dans /app
# on copie d'abord le package.json seul pour des raisons d'optimisation (histoires de cache...)
# permet aussi de refaire touts les étapes depuis la step 3 si le package.json change

EXPOSE 4000
# C'est juste de la doc, ca n'expose pas vraiment le port 3000
# le mode exterieur (mon ordi) ne peux pas parler avec un container docker (securitée)

## RUNNING
CMD ["node", "index.js"]


# docker image ls
#   liste les images

# docker image rm 36274f1a4036
#   supprime l'image avec l'id 36274f1a4036

# docker build -t node-app-image .
#   build l'image avec un titre (nom) node-app-image
#   . signifie "regarde le Dockerfile du dossier courrant"

# docker run -p 4000:3000 -d --name node-app node-app-image
#   création du container depuis l'image
#   docker run [OPTIONS] <imagesToBuild>
#   -d = detatched mode
#   (Docker container runs in the background of your terminal. It does not receive input or display output.)
#   3000 = port surlequel on va envoyer le trafique dans le container (port de l'app)
#   4000 = port surlequel on recoir des requetes du monde exterieur

# docker ps
#   voir les containers qui tournent

# docker rm node-app -f
#   suppr le container node-app de force (sans le stopper avant)

# docker exec -it node-app bash
# permet de rentrer dans le bash du container qui a la nom node-app en (-it mode interactif)
# exit (pout sortir du container)

# on a pas besoin des node_modules et du Dockerfile pour faire fonctionner l'api
# on ajoute donc le fichier .dockerignore 
