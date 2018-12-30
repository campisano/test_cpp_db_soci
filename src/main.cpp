#include <iostream>
#include <stdexcept>
#include <string>

#include <soci.h>
#include <soci-postgresql.h>

int main()
{
    try
    {

        soci::session db(
            soci::postgresql, (
                "hostaddr=127.0.0.1 port=5432"
                " user=postgres password=postgres dbname=tstcppdb"));

        soci::transaction tx(db);

        std::string name, in, out;
        long len;
        std::string query("SELECT typname, typlen, typinput, typoutput"
                          " FROM pg_type LIMIT 5;");

        std::cout << std::endl << "Executing [" << query << "]:" << std::endl;

        soci::statement stm = (db.prepare << query,
                               soci::into(name), soci::into(len),
                               soci::into(in), soci::into(out));
        stm.execute();

        while(stm.fetch())
        {
            std::cout << "name: " << name
                      << "\tlen: " << len
                      << "\tin: " << in
                      << "\tout: " << out
                      << std::endl;
        }

        tx.commit();

    }
    catch(std::exception const & _ex)
    {
        std::cerr << "Error: " << _ex.what() << std::endl;
        throw;
    }

    return 0;
}
