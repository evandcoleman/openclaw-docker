FROM ghcr.io/openclaw/openclaw:latest

USER root

# Install GitHub CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl gpg && \
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends gh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Playwright Chromium + system dependencies
# npx is on node user's PATH, so use ENV to make it available to root
ENV PATH="/usr/local/lib/node_modules/.bin:/usr/local/bin:${PATH}"
RUN npx playwright install --with-deps chromium

USER node
