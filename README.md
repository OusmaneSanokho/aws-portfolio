# Ousmane Sanokho — Portfolio, Hosted on AWS

**Live site:** https://dge9hqy7t2uwp.cloudfront.net

This repository holds two things: my personal portfolio website, and the actual cloud infrastructure that runs it. Most personal websites are just a file uploaded somewhere. This one is built and deployed the way professional engineering teams do it — as code, automated, and documented — as a hands-on project to learn AWS, Infrastructure as Code, and CI/CD.

If you're not from a technical background: think of this README as a behind-the-scenes tour of how this website actually works, written in plain language, with the technical terms explained as they come up.

---

## What's actually happening when you visit the site

You (browser)
│
▼
Amazon CloudFront ← a global network of servers that delivers the site quickly,
│ wherever you are in the world, over a secure (HTTPS) connection
▼
Amazon S3 (private) ← the actual storage location of the website's files, kept
locked down so it can only be reached through CloudFront


And separately, whenever the site's content changes:

I push a code change to GitHub
│
▼
GitHub Actions ← automatically picks up the change
│
▼
Uploads the new files to the storage location, then tells CloudFront
to refresh its cache — all without me manually touching AWS


## Why it's built this way

A few deliberate engineering decisions went into this, each with a reason:

- **The storage location (S3) is completely private.** It's not reachable directly from the internet at all — only CloudFront is allowed in, and only through a signed, verified connection. This is safer than the common shortcut of making file storage public, which is why AWS itself recommends against that approach.
- **CloudFront serves the site, not the storage location directly.** This gives the site free HTTPS (the padlock icon in your browser), faster loading for visitors anywhere in the world, and a proper separation between "where files live" and "how the public reaches them."
- **No custom domain yet, by choice.** A custom domain (like `ousmane.dev`) would add a small recurring cost and additional complexity that wasn't worth taking on for this stage of the project. It can be added later without rebuilding anything.
- **The infrastructure is defined as code (Terraform), not built by clicking through AWS's website.** Every AWS resource this project uses — the storage, the delivery network, the permissions — is described in code files in the `terraform/` folder. This means the entire setup can be recreated, reviewed, or safely modified, the same way software teams manage infrastructure at scale.
- **Deployment is automated, not manual.** Pushing a change to the `main` branch of this repository automatically publishes it to the live site within seconds, through a pipeline defined in `.github/workflows/deploy.yml`.
- **No long-lived AWS passwords are stored anywhere.** The automated deployment pipeline authenticates to AWS using short-lived, single-use credentials issued fresh for each run (a method called OIDC), instead of a permanent secret key sitting in GitHub that could leak.

## Tech stack

- **AWS S3** — file storage for the website
- **AWS CloudFront** — content delivery network (CDN) and HTTPS
- **AWS IAM** — access control and permissions
- **Terraform** — Infrastructure as Code, used to create and manage all of the above
- **GitHub Actions** — automated deployment pipeline

## Project status

| Phase | Status |
|---|---|
| Architecture design | Done |
| Infrastructure (S3 + CloudFront) built with Terraform | Done, live |
| Automated deployment pipeline (CI/CD) | Done, tested end-to-end |
| Custom domain | Not started (deliberately deferred) |

## Cost

This project runs entirely within AWS's free-tier limits for a personal site at this traffic level. The only things that would generate a charge are unusually high traffic (well beyond what a personal portfolio receives) or adding a custom domain later (a small, predictable cost of roughly $0.50/month for domain hosting).

## Repository structure

.
├── index.html → the actual website
├── terraform/ → infrastructure code (S3, CloudFront, IAM, all defined here)
└── .github/workflows/ → the automated deployment pipeline


## About me

I'm a Cloud Engineering student at Asia Pacific University (APU), Malaysia, building toward a career in AWS infrastructure and DevOps. This project is part of a series of hands-on AWS builds I'm documenting as I learn — reach out if you'd like to talk about it.