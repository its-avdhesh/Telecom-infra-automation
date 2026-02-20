---
- name: Deploy Telecomm Backend
  hosts: telecom_servers
  become: true

  vars:
    aws_region: "eu-north-1"
    ecr_registry: "922778709371.dkr.ecr.eu-north-1.amazonaws.com"
    image_name: "telecom-backend"
    image_tag: "latest"
    container_name: "telecom-backend"
    app_port: 3002

  tasks:

    # ─────────────────────────────────────────
    # STEP 1 — Ensure Docker is running
    # ─────────────────────────────────────────
    - name: Ensure Docker is installed
      apt:
        name: docker.io
        state: present
        update_cache: yes

    - name: Ensure Docker is started
      service:
        name: docker
        state: started
        enabled: true

    # ─────────────────────────────────────────
    # STEP 2 — Install AWS CLI (if not present)
    # ─────────────────────────────────────────
    - name: Check if AWS CLI is installed
      command: aws --version
      register: aws_cli_check
      ignore_errors: true
      changed_when: false

    - name: Install AWS CLI dependencies
      apt:
        name: [unzip, curl]
        state: present
      when: aws_cli_check.rc != 0

    - name: Download AWS CLI
      get_url:
        url: "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
        dest: /tmp/awscliv2.zip
      when: aws_cli_check.rc != 0

    - name: Unzip AWS CLI
      unarchive:
        src: /tmp/awscliv2.zip
        dest: /tmp
        remote_src: yes
      when: aws_cli_check.rc != 0

    - name: Install AWS CLI
      command: /tmp/aws/install
      when: aws_cli_check.rc != 0

    # ─────────────────────────────────────────
    # STEP 3 — Login to ECR
    # ─────────────────────────────────────────
    - name: Login to ECR using IAM role
      shell: |
        aws ecr get-login-password --region {{ aws_region }} | \
        docker login --username AWS --password-stdin {{ ecr_registry }}
      changed_when: false

    # ─────────────────────────────────────────
    # STEP 4 — Pull latest image from ECR
    # ─────────────────────────────────────────
    - name: Pull latest image from ECR
      command: docker pull {{ ecr_registry }}/{{ image_name }}:{{ image_tag }}

    # ─────────────────────────────────────────
    # STEP 5 — Stop and remove old container
    # ─────────────────────────────────────────
    - name: Stop existing container (if running)
      command: docker stop {{ container_name }}
      ignore_errors: true
      changed_when: false

    - name: Remove existing container (if exists)
      command: docker rm {{ container_name }}
      ignore_errors: true
      changed_when: false

    # ─────────────────────────────────────────
    # STEP 6 — Start new container
    # ─────────────────────────────────────────
    - name: Run Telecomm container
      command: >
        docker run -d
        --name {{ container_name }}
        --restart always
        -p {{ app_port }}:{{ app_port }}
        -e MONGO_URI="mongodb+srv://Avdhesh:zK1sXOo6Xiy9hKSu@deletelater.7mrpe1e.mongodb.net/TelecomProject"
        -e PORT={{ app_port }}
        -e JWT_SECRET="f48420fa351de3fde8294fbc964a8f38"
        {{ ecr_registry }}/{{ image_name }}:{{ image_tag }}

    # ─────────────────────────────────────────
    # STEP 7 — Verify container is running
    # ─────────────────────────────────────────
    - name: Wait for app to be ready
      wait_for:
        host: localhost
        port: "{{ app_port }}"
        timeout: 30

    - name: Check container status
      command: docker ps --filter name={{ container_name }} --filter status=running
      register: container_status
      changed_when: false

    - name: Print deployment result
      debug:
        msg: "✅ Telecomm backend is live at http://{{ inventory_hostname }}:{{ app_port }}"