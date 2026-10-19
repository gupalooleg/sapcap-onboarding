// import { Employees, UIConfiguration } from "#cds-models/EmployeesService";
import cds from "@sap/cds";

export class EmployeesService extends cds.ApplicationService {
  init() {
    /** @type {import("#cds-models/EmployeesService").Employees} */
    const Employees = this.entities.Employees;
    /** @type {import("#cds-models/EmployeesService").UIConfiguration} */
    const UIConfiguration = this.entities.UIConfiguration;

    this.before(["CREATE"], Employees, async (req) => {
      const { maxID } = await SELECT.one.from(Employees).columns("max(employeeID) as maxID");
      req.data.employeeID = (maxID ?? 0) + 1;
    });

    this.on(["READ"], UIConfiguration, async (req) => {
      // const isAdmin = req.user.is("EmployeeAdministrator");
      const isAdmin = true;
      return {
        createHidden: !isAdmin,
        updateHidden: !isAdmin,
        deleteHidden: !isAdmin,
      };
    });

    return super.init();
  }
}
