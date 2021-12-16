# image docker du hub sur laquelle se baser
FROM node

WORKDIR /app

## BUILDING

COPY package.json .
# copie le package.json dans le dossier courrant, comme le WORKDIR est définie, . signifie /app

ARG NODE_ENV
RUN if [ "$NODE_ENV" = "development" ]; \
        then npm install; \
        else npm install --only=production; \
        fi
# RUN - execute une commande
# Les espaces dans le chrochet du if sont important



COPY . ./
# on copie tout les fichier dans /app
# on copie d'abord le package.json seul pour des raisons d'optimisation (histoires de cache...)
# permet aussi de refaire touts les étapes depuis la step 3 si le package.json change

ENV PORT 4000
EXPOSE $PORT
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


# docker run --env-file ./.env -p 4000:5000 -d --name node-app -v $(pwd):/app node-app-image
#   création du container depuis l'image
#   docker run [OPTIONS] <imagesToBuild>
#   -d = detatched mode
#   (Docker container runs in the background of your terminal. It does not receive input or display output.)
#   3000 = port surlequel on va envoyer le trafique dans le container (port de l'app)
#   4000 = port surlequel on recoir des requetes du monde exterieur
#   -v  pour volumes, syncrinisation de fichier entre la machine locale et le container
#       -v pathToFolderInLocal:pathToFolderInContainer
#       $(pwd) sur linux
#   --env PORT=5000
#       Overwrite une variable d'env 
#   --env-file ./.env
#       prend un fichier en var d'environement

# docker ps -a
#   voir les containers qui tournent
#   -a pour voir même les containers qui ne tournent pas

# docker logs node-app 
#   voir les logs du container node-app au moment du run

# docker rm node-app -fv
#   suppr le container node-app
#   -f de force (sans le stopper avant)
#   -fv avec tout ses volumes

# docker exec -it node-app bash
# permet de rentrer dans le bash du container qui a la nom node-app en (-it mode interactif)
#   exit (pout sortir du container)
#   printenv (pout afficher les var d'env)

# on a pas besoin des node_modules et du Dockerfile pour faire fonctionner l'api
# on ajoute donc le fichier .dockerignore 

# docker volume ls 
#   liste les volumes 

# docker volume rm volumeName
# docker volume prune
#   supprime les volumes 
#   prune = tout les volumes innutiles 
