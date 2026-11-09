// import { Candidates, UIConfiguration } from "#cds-models/CandidatesService";
import cds from "@sap/cds";

export class CandidatesService extends cds.ApplicationService {
  init() {
    /** @type {import("#cds-models/CandidatesService").Candidates} */
    const Candidates = this.entities.Candidates;

    const Employees = this.entities.Employees;
    /** @type {import("#cds-models/CandidatesService").UIConfiguration} */
    const UIConfiguration = this.entities.UIConfiguration;

    this.before(["CREATE"], Candidates, async (req) => {
      const { maxID } = await SELECT.one.from(Candidates).columns("max(candidateID) as maxID");
      req.data.candidateID = (maxID ?? 0) + 1;
    });

    this.on(["READ"], UIConfiguration, async (req) => {
      const isAdmin = req.user.is("CandidateAdministrator");
      return {
        createHidden: !isAdmin,
        updateHidden: !isAdmin,
        deleteHidden: !isAdmin,
      };
    });

    this.on("addAsEmployee", Candidates, async (req) => {
      const candidateID = req.params[0].ID;
      let candidate = await SELECT.one.from(Candidates).where({ID: candidateID});

      if (!candidate) {
          req.reject(404, 'CANDIDATE_NOT_FOUND');
      }

      if (candidate.employee_ID) {
          req.reject(400, 'CANDIDATE_ALREADY_EMPLOYEE');
      }
      
      const requestDate = new Date(req.timestamp);
      const beginDate = requestDate.toISOString().split('T')[0];
      requestDate.setFullYear(requestDate.getFullYear()+1);
      const endDate = requestDate.toISOString().split('T')[0];
      
      const { maxID } = await SELECT.one.from(Employees).columns("max(employeeID) as maxID");
      const employeeID = (maxID ?? 0) + 1;
      
      const employeeData = {
        name: candidate.name,
        country_code: candidate.country_code,
        role_code: candidate.role_code,
        beginDate: beginDate,
        endDate: endDate,
        performanceRate: 100,
        employeeID: employeeID
      };

      const created = await INSERT.into(Employees).entries([employeeData]);
      const [{ID:employee_ID}] = [...created];
      await UPDATE(Candidates, candidateID).with({employee_ID: employee_ID});
      candidate = await SELECT.one.from('Candidates').where({ ID: candidateID });

      return candidate;
    });

    return super.init();
  }
}
