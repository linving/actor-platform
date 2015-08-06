package im.actor.model.api.updates;
/*
 *  Generated by the Actor API Scheme generator.  DO NOT EDIT!
 */

import im.actor.model.droidkit.bser.Bser;
import im.actor.model.droidkit.bser.BserParser;
import im.actor.model.droidkit.bser.BserObject;
import im.actor.model.droidkit.bser.BserValues;
import im.actor.model.droidkit.bser.BserWriter;
import im.actor.model.droidkit.bser.DataInput;
import im.actor.model.droidkit.bser.DataOutput;
import im.actor.model.droidkit.bser.util.SparseArray;
import org.jetbrains.annotations.Nullable;
import org.jetbrains.annotations.NotNull;
import com.google.j2objc.annotations.ObjectiveCName;
import static im.actor.model.droidkit.bser.Utils.*;
import java.io.IOException;
import im.actor.model.network.parser.*;
import java.util.List;
import java.util.ArrayList;
import im.actor.model.api.*;

public class UpdateUserContactsChanged extends Update {

    public static final int HEADER = 0x86;
    public static UpdateUserContactsChanged fromBytes(byte[] data) throws IOException {
        return Bser.parse(new UpdateUserContactsChanged(), data);
    }

    private int uid;
    private List<ContactRecord> contactRecords;

    public UpdateUserContactsChanged(int uid, @NotNull List<ContactRecord> contactRecords) {
        this.uid = uid;
        this.contactRecords = contactRecords;
    }

    public UpdateUserContactsChanged() {

    }

    public int getUid() {
        return this.uid;
    }

    @NotNull
    public List<ContactRecord> getContactRecords() {
        return this.contactRecords;
    }

    @Override
    public void parse(BserValues values) throws IOException {
        this.uid = values.getInt(1);
        List<ContactRecord> _contactRecords = new ArrayList<ContactRecord>();
        for (int i = 0; i < values.getRepeatedCount(4); i ++) {
            _contactRecords.add(new ContactRecord());
        }
        this.contactRecords = values.getRepeatedObj(4, _contactRecords);
    }

    @Override
    public void serialize(BserWriter writer) throws IOException {
        writer.writeInt(1, this.uid);
        writer.writeRepeatedObj(4, this.contactRecords);
    }

    @Override
    public String toString() {
        String res = "update UserContactsChanged{";
        res += "uid=" + this.uid;
        res += ", contactRecords=" + this.contactRecords.size();
        res += "}";
        return res;
    }

    @Override
    public int getHeaderKey() {
        return HEADER;
    }
}
