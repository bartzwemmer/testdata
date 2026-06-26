import os
from sqlalchemy import event
from sqlalchemy.engine import Engine

@event.listens_for(Engine, "connect")
def on_connect(dbapi_connection, connection_record):
    # Only run for duckdb connections
    if 'duckdb' in str(type(dbapi_connection)).lower():
        try:
            # Install and load required extensions
            dbapi_connection.execute("INSTALL spatial; LOAD spatial;")
            dbapi_connection.execute("INSTALL httpfs; LOAD httpfs;")
            
            # Execute the init_database.sql script
            if os.path.exists('/app/init_database.sql'):
                with open('/app/init_database.sql', 'r') as f:
                    sql = f.read()
                    # Substitute getenv('...') with actual environment variables
                    import re
                    
                    def replacer(match):
                        var_name = match.group(1)
                        # We return the substituted string wrapped in single quotes, because
                        # the SQL expects a string literal. e.g. getenv('S3_ACCESS_KEY') -> 'actual_key'
                        val = os.environ.get(var_name, '')
                        return f"'{val}'"
                        
                    sql = re.sub(r"getenv\(\s*'([^']+)'\s*\)", replacer, sql)
                    
                    # Split on ';' to execute statements individually if needed, 
                    # but python execute() can run multiple statements. Let's split just in case.
                    statements = [s.strip() for s in sql.split(';') if s.strip()]
                    for stmt in statements:
                        dbapi_connection.execute(stmt)
                        
        except Exception as e:
            # Ignore if already exists
            print(f"Failed to initialize DuckDB memory database: {e}")
            pass
