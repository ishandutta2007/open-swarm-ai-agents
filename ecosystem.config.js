module.exports = {
  apps : [{
    name: 'app',
    script: 'src/main.py',
    interpreter: 'python3',
    watch: true,
    env: {
      'PYTHONUNBUFFERED': 'true'
    }
  }]
};
