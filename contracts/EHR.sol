// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

contract EHR {
    struct Record {
        string recordID;
        string diagnosis;
        string[] treatment;
        string[] labFiles;
        address doctorID;
        uint256 createdAt;
    }

    struct Patient {
        address patientID;
        string bloodType;
        string name;
        uint age;
        string[] allegies;
        string[] records;
    }

    struct Doctor {
        address doctorID;
        string name;
    }

    mapping(address => Patient) patients;
    mapping(address => Doctor) doctors;
    mapping(string => Record) records;

    modifier isPatientExists() {
        require(patients[msg.sender].patientID != msg.sender);
        _;
    }

    modifier isDoctor() {
        require(doctors[msg.sender].doctorID == msg.sender);
        _;
    }

    modifier isDoctorExists() {
        require(doctors[msg.sender].doctorID != msg.sender);
        _;
    }

    modifier isAuthorized(address patientID) {
        require(
            patientID == msg.sender ||
                doctors[msg.sender].doctorID == msg.sender
        );
        _;
    }

    function createUser(
        string memory name,
        uint age,
        string[] memory allergies,
        string memory bloodType
    ) public isPatientExists returns (bool success) {
        patients[msg.sender] = Patient(
            msg.sender,
            bloodType,
            name,
            age,
            allergies,
            new string[](0)
        );

        success = true;
        return success;
    }

    function addRecord(
        string memory recordID,
        address patientID,
        string[] memory labfiles,
        string memory diagnosis,
        string[] memory treatment
    ) public isDoctor returns (bool success) {
        records[recordID] = Record(
            recordID,
            diagnosis,
            treatment,
            labfiles,
            msg.sender,
            block.timestamp
        );

        patients[patientID].records.push(recordID);

        success = true;
        return success;
    }

    function getPatient(
        address patientID
    )
        public
        view
        isAuthorized(patientID)
        returns (
            string memory,
            uint,
            string[] memory,
            string memory,
            Record[] memory
        )
    // Record[] memory records
    {
        uint size = patients[patientID].records.length;
        Record[] memory _records = new Record[](size);

        for (uint x = 0; size < size; x++) {
            _records[x] = records[patients[patientID].records[x]];
        }

        return (
            patients[patientID].name,
            patients[patientID].age,
            patients[patientID].allegies,
            patients[patientID].bloodType,
            _records
        );
    }

    function addDoctor(string memory name) public isDoctorExists {
        doctors[msg.sender] = Doctor(msg.sender, name);
    }
}
