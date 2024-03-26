DATABASE_USER=user
DATABASE_PASSWORD=pass

createdb:
	docker-compose exec db createdb --username=user --owner=user bank

dropdb:
	docker-compose exec db dropdb bank -U user

migrateup:
	migrate -path db/migration -database "postgresql://${DATABASE_USER}:${DATABASE_PASSWORD}@localhost:5432/bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://${DATABASE_USER}:${DATABASE_PASSWORD}@localhost:5432/bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/matheusreis1/simple_bank/db/sqlc Store
