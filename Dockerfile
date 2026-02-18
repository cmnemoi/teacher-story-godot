# Étape 1: Build du projet Godot
FROM barichello/godot-ci:4.6 AS builder

WORKDIR /build

# Copier tout le projet
COPY . .

# Créer le dossier de build
RUN mkdir -p build/web

# Exporter le projet pour le Web
# Le template d'export web doit être installé dans l'image godot-ci
RUN godot --headless --verbose --export-release "Web" build/web/index.html

# Étape 2: Serveur nginx pour servir les fichiers
FROM nginxinc/nginx-unprivileged:1.29-alpine

# Copier la configuration nginx personnalisée
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

# Copier les fichiers buildés depuis l'étape précédente
COPY --from=builder /build/build/web /usr/share/nginx/html

# Exposer le port 8080 (nginx-unprivileged écoute sur 8080 par défaut)
EXPOSE 8080

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1
