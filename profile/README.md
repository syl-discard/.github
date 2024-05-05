# Discard, a messaging platform

> :warning: **Discard is in no way affiliated with Discord!** This project is non-profit, open-source, and is created to learn more about enterprise architecture and messaging in general.

The original social media messaging Discord is in discord. Users are not happy about the way Discord is managing its business and their monetization policies in particular. This is why Discard is now in the making. Discard Inc., a fictional company, is a start-up company that is looking to exploit the gap in the market Discord made by its malpractice. Discard will be similar to Discord, in that users can create their account, create `servers', and talk to other users in the server they are both in.

The focus of the project is to learn more about enterprise development, and the scaling and maintainability of an enterprise platform to millions of users. The focus does not lay of making the project feature-complete.

## Requirements
This project is meant to be ran together. You will need Docker and Docker Compose installed. For more information, see [here](https://docs.docker.com/engine/install/).

## Setup /w Docker Compose

This project is best ran with Docker Compose. First, you will need to create a folder, for example `discard`. Move into this folder, and clone each repository from this organization:

```sh
mkdir discard && cd discard/ && touch docker-compose.yml && \
touch init/messages-schema-init.sh && \
git clone git@github.com:syl-discard/frontend.git && \
git clone git@github.com:syl-discard/user-service.git && \
git clone git@github.com:syl-discard/message-service.git
```

Your folder structure, with `discard` as the root, should be like this:

```
.
└── discard
     ├── frontend
     ├── user-service
     ├── message-service
     ├── init
     |     └── messages-schema-init.sh
     └── docker-compose.yml
```

Open the `docker-compose.yml` file and paste the following into it: [get file contents here](https://github.com/syl-discard/.github/blob/main/docker-compose.yml).

Open the `init/messages-schema-init.sh` file and paste the following into it: [get file contents here](https://github.com/syl-discard/.github/blob/main/messages-schema-init.sh).

You can then run `docker compose build && docker compose up`.
