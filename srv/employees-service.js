// import { Employees, UIConfiguration } from "#cds-models/EmployeesService";
import cds from "@sap/cds";

export class EmployeesService extends cds.ApplicationService {
  init() {
    /** @type {import("#cds-models/EmployeesService").Employees} */
    const Employees = this.entities.Employees;

    const Candidates = this.entities.Candidates;

    const EmployeeComments = this.entities.EmployeeComments;

    const Attachments = this.entities["Employees.attachments"];

    /** @type {import("#cds-models/EmployeesService").UIConfiguration} */
    const UIConfiguration = this.entities.UIConfiguration;

    this.before(["CREATE"], Employees, async (req) => {
      const { maxID } = await SELECT.one.from(Employees).columns("max(employeeID) as maxID");
      req.data.employeeID = (maxID ?? 0) + 1;
    });

    this.before(["DELETE"], Employees, async (req) => {
      const employeeID = req.data.ID;

      await UPDATE(Candidates).where({ employee_ID: employeeID }).with({ employee_ID: null });
    });

    this.on(["READ"], UIConfiguration, async (req) => {
      const isAdmin = req.user.is("EmployeeAdministrator");
      return {
        createHidden: !isAdmin,
        updateHidden: !isAdmin,
        deleteHidden: !isAdmin,
      };
    });

    this.after(["CREATE", "DELETE"], EmployeeComments.drafts, async (_, req) => {
      const id = req.data.employee_ID;
      await this.#updateEmployeeDraftModifiedAt(id, req.timestamp);
    });

    this.after(["CREATE", "UPDATE", "DELETE"], Attachments.drafts, async (_, req) => {
      const id = req.data.up__ID;
      await this.#updateEmployeeDraftModifiedAt(id, req.timestamp);
    });

    return super.init();
  }

  async #updateEmployeeDraftModifiedAt(id, modifiedAt) {
    const Employees = this.entities.Employees;
    await UPDATE(Employees.drafts, id).set({ modifiedAt });
  }
}
