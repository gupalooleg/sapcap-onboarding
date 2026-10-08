// import { Candidates, UIConfiguration } from "#cds-models/OnboardingService";
import cds from "@sap/cds";

export class OnboardingService extends cds.ApplicationService {
  init() {
    /** @type {import("#cds-models/OnboardingService").Candidates} */
    const Candidates = this.entities.Candidates;
    /** @type {import("#cds-models/OnboardingService").UIConfiguration} */
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

    return super.init();
  }
}
