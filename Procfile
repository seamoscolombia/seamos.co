web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
client: sh -c 'rm app/assets/webpack/* || true && cd client && yarn && bundle exec rake react_on_rails:locale && yarn run build:production'
